import SwiftUI

struct CoursesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CourseCardView(title: "Professional Makeup", rating: 4, reviews: 182, price: 120, tag: "Make up", color: .carbon)
                CourseCardView(title: "Facial Treatments", rating: 3, reviews: 145, price: 95, tag: "Facial", color: .primaryColor)
                CourseCardView(title: "Acrylic Nail Techniques", rating: 5, reviews: 211, price: 135, tag: "Nails", color: .carbon)
            }
            .padding()
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
