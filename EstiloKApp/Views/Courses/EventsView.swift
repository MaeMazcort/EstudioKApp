import SwiftUI

struct EventsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                EventCardView(date: "May 8, 2025 | 5:00 - 7:30 PM", title: "Masterclass: Social Makeup", location: "Online via Zoom", participants: 75)
                EventCardView(date: "May 15, 2025 | 12:00 - 3:30 PM", title: "Beauty and Aesthetics Fair", location: "Cholula, Puebla MX", participants: 120)
                EventCardView(date: "May 22, 2025 | 4:00 - 6:30 PM", title: "Nail Art Workshop", location: "Online via Zoom", participants: 50)
            }
            .padding()
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
