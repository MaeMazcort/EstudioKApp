import SwiftUI

struct BeautyMainView: View {
    @State private var selectedTab = "Courses"
    let tabs = ["Courses", "Experts", "Events"]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // Mostrar encabezado solo si NO estamos en CourseDetailView
                if selectedTab != "Detail" {
                    // HEADER
                    HStack {
                        Text("Beauty")
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    .padding(.horizontal)

                    // TABS
                    HStack(spacing: 16) {
                        ForEach(tabs, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                Text(tab)
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedTab == tab ? .white : .carbon)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(selectedTab == tab ? Color.primaryColor : Color.lightGray)
                                            .shadow(color: Color.blue.opacity(0.25), radius: 10, x: 0, y: 4)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // CONTENT
                Group {
                    if selectedTab == "Courses" {
                        CoursesView()
                    } else if selectedTab == "Experts" {
                        ExpertsView()
                    } else if selectedTab == "Events" {
                        EventsView()
                    }
                }
                .padding(.horizontal)
                .padding(.top, selectedTab != "Detail" ? 10 : 0)

                Spacer()
            }
            .padding(.top) // keeps everything at the top
        }
    }
}


struct BeautyMainView_Previews: PreviewProvider {
    static var previews: some View {
        BeautyMainView()
            .previewLayout(.sizeThatFits)
    }
}

