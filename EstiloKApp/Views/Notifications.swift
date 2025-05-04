import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct AppointmentNotification: Identifiable {
    var id: String
    var date: String
    var time: String
    var read: Bool
    var createdAt: TimeInterval
}

struct NotificationsView: View {
    @State private var notifications: [AppointmentNotification] = []
    @State private var isLoading = true
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss
    
    var databaseRef: DatabaseReference = Database.database().reference()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.carbon)
                        .padding()
                }
                
                Spacer()
                
                Text("Notifications")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.carbon)
                
                Spacer()
                
                Button(action: {
                    markAllAsRead()
                }) {
                    Text("Mark all as read")
                        .font(.subheadline)
                        .foregroundColor(.primaryColor)
                        .padding()
                }
            }
            .padding(.horizontal)
            
            // Content
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
                    .scaleEffect(1.5)
                Spacer()
            } else if notifications.isEmpty {
                Spacer()
                VStack(spacing: 20) {
                    Image(systemName: "bell.slash")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("No notifications yet")
                        .font(.title3)
                        .foregroundColor(.carbon)
                    
                    Text("When you book appointments, they will appear here")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(notifications.sorted { $0.createdAt > $1.createdAt }) { notification in
                            notificationCard(notification)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.cream.edgesIgnoringSafeArea(.all))
        .alert("Info", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationBarHidden(true)
        .onAppear {
            fetchNotifications()
        }
    }
    
    private func notificationCard(_ notification: AppointmentNotification) -> some View {
        HStack(alignment: .top, spacing: 12) {
            // Unread indicator
            if !notification.read {
                Circle()
                    .fill(Color.primaryColor)
                    .frame(width: 10, height: 10)
                    .padding(.top, 6)
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 10, height: 10)
                    .padding(.top, 6)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Appointment Scheduled")
                    .font(.headline)
                    .fontWeight(notification.read ? .regular : .semibold)
                    .foregroundColor(.carbon)
                
                Text("Your appointment has been scheduled for \(notification.date) at \(notification.time)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                
                // Format relative time
                Text(relativeTimeString(from: notification.createdAt))
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.8))
                    .padding(.top, 4)
            }
            
            Spacer()
            
            // Read/Unread button
            Button(action: {
                toggleReadStatus(notification)
            }) {
                Image(systemName: notification.read ? "envelope.open" : "envelope")
                    .foregroundColor(notification.read ? .gray : .primaryColor)
                    .padding(8)
            }
        }
        .padding()
        .background(notification.read ? Color.white : Color.secondaryColor.opacity(0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            if !notification.read {
                markAsRead(notification)
            }
        }
    }
    
    private func fetchNotifications() {
        guard let userID = Auth.auth().currentUser?.uid else {
            alertMessage = "User not authenticated"
            showAlert = true
            isLoading = false
            return
        }
        
        databaseRef.child("appointments").child(userID).observe(.value) { snapshot in
            var newNotifications: [AppointmentNotification] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let value = snap.value as? [String: Any],
                   let date = value["date"] as? String,
                   let time = value["time"] as? String {
                    
                    let read = (value["read"] as? Bool) ?? false
                    let createdAt = value["createdAt"] as? TimeInterval ?? Date().timeIntervalSince1970
                    
                    let notification = AppointmentNotification(
                        id: snap.key,
                        date: date,
                        time: time,
                        read: read,
                        createdAt: createdAt
                    )
                    
                    newNotifications.append(notification)
                }
            }
            
            self.notifications = newNotifications
            self.isLoading = false
        }
    }
    
    private func markAsRead(_ notification: AppointmentNotification) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        databaseRef.child("appointments").child(userID).child(notification.id).updateChildValues([
            "read": true
        ])
    }
    
    private func toggleReadStatus(_ notification: AppointmentNotification) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        databaseRef.child("appointments").child(userID).child(notification.id).updateChildValues([
            "read": !notification.read
        ])
    }
    
    private func markAllAsRead() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        for notification in notifications where !notification.read {
            databaseRef.child("appointments").child(userID).child(notification.id).updateChildValues([
                "read": true
            ])
        }
    }
    
    private func relativeTimeString(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let now = Date()
        let components = Calendar.current.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let day = components.day, day > 0 {
            return day == 1 ? "Yesterday" : "\(day) days ago"
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        } else {
            return "Just now"


        }
    }
}

#Preview {
    NotificationsView()
}
