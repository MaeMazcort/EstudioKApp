import SwiftUI

enum BeautyTab: String, CaseIterable {
    case courses = "Courses"
    case experts = "Experts"
    case events = "Events"
}

struct BeautyView: View {
    @State private var selectedTab: BeautyTab = .courses

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(BeautyTab.allCases, id: \.self) { tab in
                    Button(action: { selectedTab = tab }) {
                        Text(tab.rawValue)
                            .fontWeight(.bold)
                            .padding()
                            .background(selectedTab == tab ? Color.primaryColor : Color.secondaryColor.opacity(0.2))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(selectedTab == tab ? 0.1 : 0), radius: 4, x: 0, y: 2)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)

            Spacer()

            switch selectedTab {
            case .courses:
                CoursesView()
            case .experts:
                ExpertsView()
            case .events:
                EventsView()
            }
        }
    }
}

struct BeautyView_Previews: PreviewProvider {
    static var previews: some View {
        BeautyView()
    }
}

