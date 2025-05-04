import SwiftUI

struct CoursesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink {
                        CourseDetailView(
                            title: "Professional Makeup",
                            price: 120,
                            rating: 4,
                            students: 425,
                            tag: "Make up",
                            lessons: 32,
                            duration: "24 hours",
                            hasCertificate: true,
                            hasUnlimitedAccess: true,
                            description: "Become an expert in professional makeup. You’ll learn cutting-edge techniques, use of quality products and application for different events and occasions.",
                            color: .carbon,
                            courseImage: "conditioner"
                        )
                    } label: {
                        CourseCardView(title: "Professional Makeup", rating: 4, reviews: 182, price: 120, tag: "Make up", color: .carbon)
                    }

                    NavigationLink {
                        CourseDetailView(
                            title: "Facial Treatments",
                            price: 95,
                            rating: 3,
                            students: 312,
                            tag: "Facial",
                            lessons: 28,
                            duration: "18 hours",
                            hasCertificate: true,
                            hasUnlimitedAccess: true,
                            description: "Learn techniques for skin rejuvenation, hydration and facial massage using high-quality skincare products.",
                            color: .primaryColor,
                            courseImage: "facial_image"
                        )
                    } label: {
                        CourseCardView(title: "Facial Treatments", rating: 3, reviews: 145, price: 95, tag: "Facial", color: .primaryColor)
                    }

                    NavigationLink {
                        CourseDetailView(
                            title: "Acrylic Nail Techniques",
                            price: 135,
                            rating: 5,
                            students: 490,
                            tag: "Nails",
                            lessons: 36,
                            duration: "20 hours",
                            hasCertificate: true,
                            hasUnlimitedAccess: true,
                            description: "Master acrylic nail design with step-by-step guidance on shapes, trends and safe application.",
                            color: .carbon,
                            courseImage: "nails_image"
                        )
                    } label: {
                        CourseCardView(title: "Acrylic Nail Techniques", rating: 5, reviews: 211, price: 135, tag: "Nails", color: .carbon)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct CourseCardView: View {
    let title: String
    let rating: Int
    let reviews: Int
    let price: Int
    let tag: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            // Title background
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(color)
                .cornerRadius(20, corners: [.topLeft, .topRight])

            // Stars and reviews
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .foregroundColor(.primaryColor)
                }
                Text("(\(reviews))")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("$\(price)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.carbon)
            }
            .padding(.horizontal)

            // Tag button
            HStack {
                Text(tag)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.carbon)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.cream)
                    .cornerRadius(20)
                    .shadow(color: Color.carbon.opacity(0.3), radius: 10, x: 0, y: 4)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(0.4), lineWidth: 1)
        )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
