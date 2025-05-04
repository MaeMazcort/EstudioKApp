import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ProfileView: View {
    @State private var userName: String = "Loading..."  // Nombre del usuario
    @State private var userImageUrl: String = ""  // URL de la imagen del perfil

    let buyAgain = [
        Product(name: "Livingproof Kit", price: "$259.00", imageName: "kit"),
        Product(name: "Eco Conditioner", price: "$179.00", imageName: "conditioner"),
        Product(name: "Sunflower Serum", price: "$99.00", imageName: "serum")
    ]
    
    // Cargar los datos del usuario desde Firebase Realtime Database
    func loadUserProfile() {
        if let user = Auth.auth().currentUser {
            let ref = Database.database().reference()
            let userRef = ref.child("users").child(user.uid)
            
            userRef.observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String: Any] {
                    // Recuperar el nombre y la URL de la imagen del perfil
                    self.userName = value["firstName"] as? String ?? "No Name"
                    self.userImageUrl = value["profileImageUrl"] as? String ?? ""
                } else {
                    print("No data available or error fetching data.")
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Encabezado
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome Back,")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(userName)  // Muestra el nombre del usuario
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.carbon)
                    }

                    Spacer()

                    if !userImageUrl.isEmpty {
                        // Si tenemos la URL de la imagen, la mostramos
                        AsyncImage(url: URL(string: userImageUrl)) { image in
                            image.resizable()
                                 .scaledToFill()
                                 .clipShape(Circle())
                                 .overlay(Circle().stroke(Color.primaryColor, lineWidth: 2))
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .frame(width: 60, height: 60)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                }
                .padding()

                Divider()
                    .background(Color.gray.opacity(0.2))

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Historial de compras
                        Text("Buy Again")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.carbon)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(buyAgain, id: \.name) { product in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(product.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .background(Color.secondaryColor)
                                            .cornerRadius(12)

                                        Text(product.name)
                                            .font(.subheadline)
                                            .foregroundColor(.carbon)
                                            .lineLimit(1)

                                        Text(product.price)
                                            .font(.subheadline)
                                            .foregroundColor(.primaryColor)
                                    }
                                    .frame(width: 120)
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Opciones adicionales
                        VStack(spacing: 16) {
                            ProfileOptionRow(title: "My Orders", icon: "bag.fill")
                            ProfileOptionRow(title: "Favorites", icon: "heart.fill")
                            
                            // Redirigir a SettingsView
                            NavigationLink(destination: SettingsView()) {
                                ProfileOptionRow(title: "Settings", icon: "gear")
                            }
                            
                            ProfileOptionRow(title: "Help Center", icon: "questionmark.circle")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
                .background(Color.cream.ignoresSafeArea())
            }
            .onAppear {
                loadUserProfile()  // Cargar el perfil cuando la vista aparece
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true)
            .background(Color.cream)
        }
    }
}

struct ProfileOptionRow: View {
    var title: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.primaryColor)
                .frame(width: 30)

            Text(title)
                .foregroundColor(.carbon)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ProfileView()
}

