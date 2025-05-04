import SwiftUI

struct Products: View {
    var productImageName: String
    var productName: String
    var price: Double

    let productDescription: String = "A dual-action exfoliator to smooth + refresh skin, blending natural ingredients for gentle renewal. Reveal softer, radiant skin while the calming scent uplifts your senses."
    let sellerName: String = "Tralalero Scott"
    let sellerRating: Double = 4.8
    let ordersCount: Int = 750

    @State private var quantity: Int = 1
    @State private var isFavorite: Bool = false
    @State private var navigateToCart: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var cartEnvironment: CartEnvironment

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Navigation Bar
                ZStack {
                    Color.clear.frame(height: 44)

                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.carbon)
                                .padding()
                        }

                        Spacer()
                    }
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            Color.secondaryColor

                            if UIImage(named: productImageName) != nil {
                                Image(productImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 300)
                                    .overlay(
                                        Text("Image not available")
                                            .foregroundColor(.black)
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity)

                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text(productName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.carbon)
                                Spacer()

                                Button(action: {}) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.primaryColor)
                                        .font(.title2)
                                }

                                Button(action: {
                                    isFavorite.toggle()
                                }) {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite ? .opaqueRed : .gray)
                                        .font(.title2)
                                }
                            }

                            HStack(spacing: 10) {
                                Image("seller_avatar")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(sellerName)
                                        .fontWeight(.medium)
                                        .foregroundColor(.carbon)

                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.mustardYellow)
                                            .font(.caption)

                                        Text("\(sellerRating, specifier: "%.1f") Seller rating")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }

                                Spacer()

                                HStack {
                                    Image(systemName: "bag.fill")
                                        .font(.caption)
                                        .foregroundColor(.gray)

                                    Text("\(ordersCount)+ Ordered")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }

                            Text(productDescription)
                                .font(.body)
                                .foregroundColor(.carbon)
                                .padding(.vertical, 10)

                            HStack {
                                Button(action: {
                                    if quantity > 1 { quantity -= 1 }
                                }) {
                                    Circle()
                                        .fill(Color.cream)
                                        .frame(width: 36, height: 36)
                                        .overlay(Text("-").font(.title2).fontWeight(.semibold).foregroundColor(.carbon))
                                }

                                Text("\(quantity)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.carbon)
                                    .frame(width: 40)

                                Button(action: { quantity += 1 }) {
                                    Circle()
                                        .fill(Color.cream)
                                        .frame(width: 36, height: 36)
                                        .overlay(Text("+").font(.title2).fontWeight(.semibold).foregroundColor(.carbon))
                                }

                                Spacer()

                                Text("$\(price, specifier: "%.0f")")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primaryColor)
                            }
                        }
                        .padding()
                    }
                }

                HStack(spacing: 10) {
                    NavigationLink(
                        destination: CartView().environmentObject(cartEnvironment),
                        isActive: $navigateToCart
                    ) {
                        Button(action: {
                            cartEnvironment.cart.addItem(
                                name: productName,
                                price: price,
                                imageUrl: productImageName,
                                quantity: quantity
                            )
                            navigateToCart = true
                        }) {
                            Text("Add to cart")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.cream)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.carbon)
                                .cornerRadius(10)
                        }
                    }

                    Button(action: {}) {
                        Image(systemName: "message.fill")
                            .font(.title2)
                            .foregroundColor(.cream)
                            .frame(width: 50, height: 50)
                            .background(Color.carbon)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.cream)
                .shadow(color: Color.gray.opacity(0.05), radius: 5, x: 0, y: -5)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .background(Color.cream)
        }
    }
}

// Preview
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Products(productImageName: "espa", productName: "ESPA Cream", price: 145.0)
            .environmentObject(CartEnvironment.shared)
    }
}

