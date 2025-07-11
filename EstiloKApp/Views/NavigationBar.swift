import SwiftUI
import MapKit

struct NavigationBar: View {
    @State private var selectedTab = 2
    
    var body: some View {
        // Eliminamos el NavigationView anidado del TabView
        TabView(selection: $selectedTab) {
            // Favorites/Heart Tab
            BookAppointmentView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Appoinments")
                }
                .tag(0)
            
        
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(1)
            // Home Tab
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(2)
            
            
            BeautyMainView()
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("Beauty")
                }
                .tag(3)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                .tag(4)
            
        }
        .accentColor(.primaryColor) // Color de los íconos seleccionados
        .navigationBarBackButtonHidden(true)
    }
}





#Preview {
    NavigationBar()
}
