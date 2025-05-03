import SwiftUI
import MapKit

struct NavigationBar: View {
    @State private var selectedTab = 2
    
    var body: some View {
        // Eliminamos el NavigationView anidado del TabView
        TabView(selection: $selectedTab) {
            // Favorites/Heart Tab
            SocialGeneralView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
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
            
            
            // Chat/Messages Tab
            Text("Messages")
                .tabItem {
                    Image(systemName: "message")
                    Text("Messages")
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
