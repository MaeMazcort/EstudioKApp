import SwiftUI

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
