import SwiftUI

struct EventsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                EventCardView(date: "May 8, 2025 | 5:00 - 7:30 PM", title: "Masterclass: Social Makeup", location: "Online via Zoom", participants: 75, color: .carbon)
                EventCardView(date: "May 15, 2025 | 12:00 - 3:30 PM", title: "Beauty and Aesthetics Fair", location: "Cholula, Puebla MX", participants: 120, color: .primaryColor)
                EventCardView(date: "May 22, 2025 | 4:00 - 6:30 PM", title: "Nail Art Workshop", location: "Online via Zoom", participants: 50, color: .carbon)
            }
            .padding()
        }
    }
}

struct EventCardView: View {
    let date: String
    let title: String
    let location: String
    let participants: Int
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with date
            Text(date)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(color)
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))

            // Title and location
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .bold()
                Text(location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // Participants and register button
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.primaryColor)
                    Text("\(participants) participants")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.carbon)
                }

                Spacer()

                Button(action: {
                    print("Register for \(title)")
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.carbon)
                        .cornerRadius(20)
                        .shadow(color: .blue.opacity(0.15), radius: 10, x: 0, y: 6)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        )
        .shadow(color: .blue.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
