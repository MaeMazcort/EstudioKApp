import SwiftUI

struct ExpertCardView: View {
    let name: String
    let role: String
    let rating: Int
    let reviews: Int

    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(name).bold()
                Text(role).font(.caption)
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < rating ? "star.fill" : "star")
                            .foregroundColor(.primaryColor)
                            .font(.caption)
                    }
                    Text("(\(reviews))")
                        .font(.caption)
                }
            }
            Spacer()
            Button("Contact") {}
                .padding(6)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct EventCardView: View {
    let date: String
    let title: String
    let location: String
    let participants: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(date)
                .font(.caption)
                .padding()
                .background(Color.primaryColor)
                .foregroundColor(.white)
                .cornerRadius(20)
            Text(title).bold()
            Text(location).font(.caption)
            HStack {
                Image(systemName: "person.2")
                Text("\(participants) participants")
                    .font(.caption)
                Spacer()
                Button("Register") {}
                    .padding(6)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3)))
    }
}
