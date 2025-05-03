import SwiftUI

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
                        .foregroundColor(.primaryText)
                }
                
                Spacer()
                
                Text("Your Cart")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                Spacer()
                
                Button(action: {
                    // Notification button action
                }) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.primaryText)
                }
            }
            .padding()
            .background(Color.primaryBackground)
            
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
                
                // Space for confirmation button
                Spacer()
                    .frame(height: 80)
            }
            .background(Color.secondaryBackground)
            
            // Confirmation button
            VStack {
                Button(action: {
                    // Order confirmation action
                }) {
                    Text("Confirm order")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryBackground)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                }
                
                // Loading indicator (optional)
                Rectangle()
                    .fill(Color.secondaryText.opacity(0.2))
                    .frame(height: 4)
                    .frame(width: 40)
                    .cornerRadius(2)
                    .padding(.vertical)
            }
            .padding(.bottom)
            .background(Color.primaryBackground)
        }
        .background(Color.primaryBackground)
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
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .padding(8)
            
            // Product info
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.primaryText)
                
                Text("$\(Int(item.price))")
                    .font(.subheadline)
                    .foregroundColor(.primaryText)
            }
            
            Spacer()
            
            // Delivery time
            Text(item.time)
                .font(.subheadline)
                .foregroundColor(.secondaryText)
                .padding(.trailing, 4)
            
            // Quantity control
            HStack(spacing: 8) {
                Button(action: decrementAction) {
                    ZStack {
                        Circle()
                            .fill(Color.secondaryBackground)
                            .frame(width: 32, height: 32)
                        
                        Text("-")
                            .font(.headline)
                            .foregroundColor(.primaryText)
                    }
                }
                
                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(minWidth: 24)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primaryText)
                
                Button(action: incrementAction) {
                    ZStack {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 32, height: 32)
                        
                        Text("+")
                            .font(.headline)
                            .foregroundColor(.primaryBackground)
                    }
                }
            }
        }
        .padding()
        .background(Color.primaryBackground)
        .cornerRadius(16)
        .shadow(color: Color.primaryText.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
