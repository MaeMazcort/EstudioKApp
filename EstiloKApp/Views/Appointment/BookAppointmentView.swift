import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct BookAppointmentView: View {
    @State private var selectedDate = Date()
    @State private var selectedTime: String? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss

    let availableTimes = [
        "10:00 AM", "11:00 AM", "12:00 PM",
        "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"
    ]
    
    var databaseRef: DatabaseReference = Database.database().reference()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.carbon)
                                .padding()
                        }

                        Spacer()
                    }
                    
                    Text("Select date and time")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.carbon)
                        .padding(.top)
                    
                    datePickerView
                    
                    Text("Available Times")
                        .font(.headline)
                        .foregroundColor(.carbon)
                        .padding(.top)
                    
                    timeSlotsGrid
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            
            // Button positioned at the bottom of the screen, above navbar
            confirmButton
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.cream)
        }
        .background(Color.cream.edgesIgnoringSafeArea(.all))
        .alert("Info", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationBarHidden(true)
    }
    
    private var datePickerView: some View {
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .tint(.primaryColor)
    }
    
    private var timeSlotsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
            ForEach(availableTimes, id: \.self) { time in
                timeSlotButton(time: time)
            }
        }
    }
    
    private func timeSlotButton(time: String) -> some View {
        let isSelected = selectedTime == time
        let backgroundColor = isSelected ? Color.primaryColor : Color.secondaryColor.opacity(0.6)
        let foregroundColor = isSelected ? Color.cream : Color.carbon
        let borderColor = isSelected ? Color.primaryColor : Color.gray.opacity(0.2)
        
        return Button(action: {
            selectedTime = time
        }) {
            Text(time)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
    }
    
    private var confirmButton: some View {
        let isEnabled = selectedTime != nil
        let backgroundColor = isEnabled ? Color.primaryColor : Color.gray.opacity(0.3)
        
        return Button(action: {
            saveAppointment()
        }) {
            Text("Save Appointment")
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.cream)
                .cornerRadius(10)
        }
        .disabled(!isEnabled)
    }
    
    private func saveAppointment() {
        guard let time = selectedTime else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        
        let appointmentData: [String: Any] = [
            "date": dateString,
            "time": time
        ]
        
        guard let userID = Auth.auth().currentUser?.uid else {
            alertMessage = "User not authenticated"
            showAlert = true
            return
        }
        
        databaseRef.child("appointments").child(userID).childByAutoId().setValue(appointmentData) { error, _ in
            if let error = error {
                alertMessage = "Database error: \(error.localizedDescription)"
            } else {
                alertMessage = "Appointment saved for \(dateString) at \(time)"
                selectedTime = nil
            }
            showAlert = true
        }
    }
}

struct BookAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        BookAppointmentView()
    }
}
