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
    @Published var items: [CartItem] = [
        CartItem(name: "Green Shampoo", price: 30, imageUrl: "shampoo", time: "4:00pm", quantity: 1),
        CartItem(name: "Green tea Hair-Food", price: 30, imageUrl: "hairfood", time: "4:00pm", quantity: 1),
        CartItem(name: "Conditioner", price: 30, imageUrl: "conditioner", time: "4:00pm", quantity: 1),
        CartItem(name: "Hair Cleanser", price: 30, imageUrl: "cleanser", time: "4:00pm", quantity: 1),
        CartItem(name: "Moroccan oil", price: 30, imageUrl: "oil", time: "4:00pm", quantity: 1)
    ]
    
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
}


struct CartView: View {
    @StateObject private var cart = Cart()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    // Back button action
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.brown)
                }
                
                Spacer()
                
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
            
            // Product list
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
            
            // Confirmation button
            Button(action: {
                // Order confirmation action
            }) {
                Text("Confirm order")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.cream)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.carbon)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            .padding(.vertical, 10)
        }
        .background(Color.cream)
    }
}

struct CartItemRow: View {
    let item: CartItem
    let incrementAction: () -> Void
    let decrementAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Product image
            Image(item.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Product info
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
                            .overlay(Text("-").foregroundColor(.gray))
                    }
                    
                    Text("\(item.quantity)")
                        .font(.headline)
                        .foregroundColor(.brown)
                        .frame(minWidth: 20)
                    
                    Button(action: incrementAction) {
                        Circle()
                            .fill(Color.mustardYellow)
                            .frame(width: 28, height: 28)
                            .overlay(Text("+").foregroundColor(.cream))
                    }
                }
            }
        }
        .padding()
        .background(Color.cream)
        .cornerRadius(16)
        .shadow(color: Color.carbon.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    CartView()
}

