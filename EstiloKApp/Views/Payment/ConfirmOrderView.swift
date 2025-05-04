import SwiftUI
import MapKit

struct OrderProduct: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let imageName: String
    let quantity: Int
}

struct ConfirmOrderView: View {
    let products = [
        OrderProduct(name: "Green tea Hair-Food", price: 30, imageName: "espa", quantity: 1),
        OrderProduct(name: "Conditioner", price: 30, imageName: "conditioner", quantity: 1)
    ]
    @State private var showMapSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // HEADER
                    HStack {
                        
                        Text("Confirm your order")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "bell")
                            .foregroundColor(.carbon)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // DELIVER TO SECTION
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Deliver to")
                            .foregroundColor(.carbon)
                            .font(.system(size: 18, weight: .bold))
                        
                        Button(action: {
                            showMapSheet.toggle()
                        }) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.secondaryColor.opacity(0.2))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.primaryColor)
                                }
                                Text("Select your location")
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "plus")
                                    .foregroundColor(.carbon)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showMapSheet) {
                        MapSheetView()
                            .presentationDetents([.fraction(0.6), .medium, .large])
                    }
                    
                    // PAYMENT METHOD SECTION
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Payment method")
                            .font(.headline)
                            .foregroundColor(.carbon)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 24, height: 24)
                                    .offset(x: -6)
                                Circle()
                                    .fill(Color.yellow)
                                    .frame(width: 24, height: 24)
                                    .offset(x: 7)
                                    .opacity(0.85)
                            }
                            .padding(.leading, 4)
                            
                            Spacer()
                            
                            Text("2121 6352 8465 ****")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        // Botón discreto para cambiar método de pago
                        NavigationLink(destination: AddPaymentMethodView()) {
                            Text("Change payment method")
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .underline()
                                .padding(.leading, 4)
                        }
                    }
                    .padding()
                    .background(Color.secondaryColor.opacity(0.5))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // PRODUCTS SECTION
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Order Summary")
                            .font(.headline)
                            .padding(.leading)
                            .foregroundColor(.carbon)
                        
                        ForEach(products) { product in
                            HStack {
                                Image(product.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.name)
                                        .font(.headline)
                                        .foregroundColor(.carbon)
                                    Text("$\(product.price)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("x\(product.quantity)")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.secondaryColor.opacity(0.4))
                                    .cornerRadius(12)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    
                    // ORDER SUMMARY + BUTTON SECTION
                    VStack(spacing: 16) {
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Sub-Total")
                                    Text("Delivery Charge")
                                    Text("Discount")
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 8) {
                                    Text("60 $")
                                    Text("15 $")
                                    Text("20 $")
                                }
                            }
                            .foregroundColor(.cream)
                            .font(.system(size: 16, weight: .regular))
                            
                            Divider()
                                .background(Color.cream)
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Text("55 $")
                                    .font(.system(size: 18, weight: .bold))
                            }
                            .foregroundColor(.cream)
                            
                            Button(action: {
                                print("Place My Order tapped")
                            }) {
                                Text("Place My Order")
                                    .foregroundColor(.primaryColor)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.cream)
                                    .cornerRadius(20)
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        .background(Color.primaryColor)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                }
            }
            .accentColor(Color.primaryColor)
            .background(Color.cream.edgesIgnoringSafeArea(.all))
        }
    }
}

// Preview
struct ConfirmOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOrderView()
    }
}

