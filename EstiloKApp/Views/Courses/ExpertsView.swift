import SwiftUI

struct ExpertsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ExpertCardView(name: "Maria Rodriguez", role: "Professional Makeup artist", rating: 4, reviews: 86)
                ExpertCardView(name: "Ana Gomez", role: "Facial Aesthetician", rating: 3, reviews: 62)
                ExpertCardView(name: "Diego Martinez", role: "Specialized male skincare specialist", rating: 4, reviews: 78)
            }
            .padding()
        }
    }
}

struct ExpertsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertsView()
    }
}
