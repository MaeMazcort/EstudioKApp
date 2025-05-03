import SwiftUI

struct BookAppointmentView: View {
    @State private var selectedDate = Date()
    @State private var selectedTime: String? = nil
    
    let availableTimes = [
        "10:00 AM", "11:00 AM", "12:00 PM",
        "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select date and time")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
            
            Text("Available Times")
                .font(.headline)
                .padding(.top)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(availableTimes, id: \.self) { time in
                    Button(action: {
                        selectedTime = time
                    }) {
                        Text(time)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedTime == time ? Color.primaryColor : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTime == time ? .white : .primary)
                            .cornerRadius(10)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                print("Cita guardada para \(selectedDate) a las \(selectedTime ?? "N/A")")
            }) {
                Text("Save Appointment")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedTime != nil ? Color.primaryColor : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(selectedTime == nil)
        }
        .padding()
    }
}

struct BookAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        BookAppointmentView()
    }
}

