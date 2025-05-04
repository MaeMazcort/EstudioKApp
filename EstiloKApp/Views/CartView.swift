import SwiftUI

// Modelo del producto en el carrito
struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let imageUrl: String
    let time: String
    var quantity: Int
}

// ViewModel del carrito
class Cart: ObservableObject {
    @Published var items: [CartItem] = []
    
    func incrementQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }
    
    func decrementQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }), items[index].quantity > 1 {
            items[index].quantity -= 1
        }
    }
    
    func addItem(name: String, price: Double, imageUrl: String, quantity: Int) {
        if let index = items.firstIndex(where: { $0.name == name }) {
            items[index].quantity += quantity
        } else {
            let newItem = CartItem(
                name: name,
                price: price,
                imageUrl: imageUrl,
                time: getCurrentTime(),
                quantity: quantity
            )
            items.append(newItem)
        }
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter.string(from: Date()).lowercased()
    }
}

// Entorno compartido del carrito
class CartEnvironment: ObservableObject {
    static let shared = CartEnvironment()
    @Published var cart = Cart()
}

// EnvironmentKey para acceder al entorno en vistas
struct CartEnvironmentKey: EnvironmentKey {
    static let defaultValue = CartEnvironment.shared
}

extension EnvironmentValues {
    var cartEnvironment: CartEnvironment {
        get { self[CartEnvironmentKey.self] }
        set { self[CartEnvironmentKey.self] = newValue }
    }
}

struct CartView: View {
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @State private var goToConfirm = false

    var body: some View {
        let cart = cartEnvironment.cart

        VStack(spacing: 0) {
            // Header
            HStack {
                
                
                Text("Your Cart")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.brown)
                
                Spacer()
                
                Button(action: {
                    // Notification button action
                }) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.brown)
                }
            }
            .padding()
            
            if cart.items.isEmpty {
                Spacer()
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text("Add some products to your cart")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.8))
                    
                    // Botón para agregar producto de prueba
                    Button(action: {
                        cart.addItem(name: "Test Product", price: 10, imageUrl: "photo", quantity: 1)
                    }) {
                        Text("Add Test Product")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(cart.items) { item in
                            CartItemRow(item: item, incrementAction: {
                                cart.incrementQuantity(for: item)
                            }, decrementAction: {
                                cart.decrementQuantity(for: item)
                            })
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                
                VStack(spacing: 8) {
                    HStack {
                        Text("Subtotal")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(calculateSubtotal(cart: cart), specifier: "%.2f")")
                            .foregroundColor(.brown)
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.headline)
                            .foregroundColor(.brown)
                        Spacer()
                        Text("$\(calculateTotal(cart: cart), specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.brown)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                
                Button(action: {
                    goToConfirm = true
                }) {
                    Text("Go to pay")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                }
                .padding(.vertical, 10)
            }
            
            NavigationLink(destination: ConfirmOrderView(), isActive: $goToConfirm) {
                EmptyView()
            }
        }
        .background(Color.white)
    }
    
    private func calculateSubtotal(cart: Cart) -> Double {
        return cart.items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    private func calculateTotal(cart: Cart) -> Double {
        return calculateSubtotal(cart: cart)
    }
}

struct CartItemRow: View {
    let item: CartItem
    let incrementAction: () -> Void
    let decrementAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            if UIImage(named: item.imageUrl) != nil {
                Image(item.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.brown)
                
                Text("$\(Int(item.price))")
                    .font(.subheadline)
                    .foregroundColor(.brown)
            }
            
            Spacer()
            
            VStack {
                Text(item.time)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    Button(action: decrementAction) {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 28, height: 28)
                            .overlay(Text("-").foregroundColor(.white))
                    }
                    
                    Text("\(item.quantity)")
                        .font(.headline)
                        .foregroundColor(.brown)
                        .frame(minWidth: 20)
                    
                    Button(action: incrementAction) {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 28, height: 28)
                            .overlay(Text("+").foregroundColor(.white))
                    }
                }
            }
        }
        .padding()
        .accentColor(Color.primaryColor)
        .background(Color.white)
        
        .cornerRadius(16)
        
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView()
                .environmentObject(CartEnvironment.shared)
        }
    }
}



