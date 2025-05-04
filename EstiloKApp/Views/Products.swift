import SwiftUI

struct Products: View {
    var productImageName: String
    var productName: String
    var price: Double

    let productDescription: String = "A dual-action exfoliator to smooth + refresh skin, blending natural ingredients for gentle renewal. Reveal softer, radiant skin while the calming scent uplifts your senses."
    let sellerName: String = "Tralalero Scott"
    let sellerRating: Double = 4.8
    let ordersCount: Int = 750

    @State private var quantity: Int = 0
    @State private var isFavorite: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Navigation Bar
            ZStack {
                Color.clear
                    .frame(height: 44)

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
                    // Product Image
                    ZStack {
                        Color.secondaryColor

                        if UIImage(named: productImageName) != nil {
                            Image(productImageName)
                                .resizable()
                                .frame(height: 250)
                        } else {
                            // Fallback image if image is missing
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

                    // Product Info
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(productName)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.carbon)
                            Spacer()

                            Button(action: {
                                // Location action
                            }) {
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

                        // Seller Info
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

                        // Product Description
                        Text(productDescription)
                            .font(.body)
                            .foregroundColor(.carbon)
                            .padding(.vertical, 10)

                        // Quantity Selector
                        HStack {
                            Button(action: {
                                if quantity > 1 {
                                    quantity -= 1
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.cream)
                                        .frame(width: 36, height: 36)

                                    Text("-")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.carbon)
                                }
                            }

                            Text("\(quantity)")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.carbon)
                                .frame(width: 40)
                                .multilineTextAlignment(.center)

                            Button(action: {
                                quantity += 1
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.cream)
                                        .frame(width: 36, height: 36)

                                    Text("+")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.carbon)
                                }
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
                
                //Add to Cart Button
                HStack(spacing: 10) {
                    Button(action: {
                        // Add to cart action
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

                    Button(action: {
                        // Chat action
                    }) {
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
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .background(Color.cream)
    }
}

// Preview
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Products(productImageName: "espa", productName: "ESPA Cream", price: 145.0)
    }
}

