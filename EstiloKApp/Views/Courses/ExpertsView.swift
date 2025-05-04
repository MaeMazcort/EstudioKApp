import SwiftUI

struct ExpertsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ExpertCardView(imageName: "maria", name: "Maria Rodriguez", role: "Professional Makeup artist", rating: 4, reviews: 86)
                ExpertCardView(imageName: "ana", name: "Ana Gomez", role: "Facial Aesthetician", rating: 4, reviews: 62)
                ExpertCardView(imageName: "diego", name: "Diego Martinez", role: "Specialized male skincare specialist", rating: 4, reviews: 78)
            }
            .padding()
        }
    }
}

struct ExpertCardView: View {
    let imageName: String
    let name: String
    let role: String
    let rating: Int
    let reviews: Int

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.headline)
                    .bold()
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < rating ? "star.fill" : "star")
                            .foregroundColor(.primaryColor)
                            .font(.subheadline)
                    }
                    Text("(\(reviews))")
                        .font(.caption)
                        .foregroundColor(.carbon)
                }
            }

            Spacer()

            Button(action: {
                print("Contact \(name)")
            }) {
                Text("Contact")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.carbon)
                    .cornerRadius(20)
                    .shadow(color: .blue.opacity(0.15), radius: 10, x: 0, y: 6)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        )
        .shadow(color: .blue.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

struct ExpertsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertsView()
    }
}
