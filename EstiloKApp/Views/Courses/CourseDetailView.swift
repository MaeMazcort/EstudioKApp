import SwiftUI

struct CourseDetailView: View {
    let title: String
    let price: Int
    let rating: Int
    let students: Int
    let tag: String
    let lessons: Int
    let duration: String
    let hasCertificate: Bool
    let hasUnlimitedAccess: Bool
    let description: String
    let color: Color
    let courseImage: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Course Image
                Image(courseImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(20)
                    .padding(.horizontal)

                // Price and Rating
                VStack(alignment: .leading, spacing: 12) {
                    Text("$\(price)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.carbon)

                    HStack(spacing: 6) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < rating ? "star.fill" : "star")
                                .foregroundColor(.primaryColor)
                        }

                        Spacer()

                        Image(systemName: "person.fill")
                            .foregroundColor(.primaryColor)
                        Text("\(students) students")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.carbon)
                    }

                    Text(tag)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.cream)
                        .cornerRadius(20)
                        .shadow(color: .blue.opacity(0.15), radius: 10, x: 0, y: 4)
                }
                .padding(.horizontal)

                // Course Details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Course Details")
                        .font(.title3)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• \(lessons) video lessons")
                        Text("• Duration: \(duration)")
                        if hasCertificate { Text("• Completion certificate") }
                        if hasUnlimitedAccess { Text("• Unlimited access") }
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal)

                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(description)
                        .font(.body)
                }
                .padding(.horizontal)

                // Enroll Button
                Button(action: {
                    print("Enroll tapped")
                }) {
                    Text("Enroll")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.carbon)
                        .cornerRadius(20)
                        .shadow(color: Color.blue.opacity(0.15), radius: 10, x: 0, y: 6)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
    }
}


struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
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
            courseImage: "photo" // system image name for preview, replace with your asset name
        )
    }
}
