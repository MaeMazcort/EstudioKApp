import SwiftUI

struct ConfirmOrderView: View {
    var body: some View {
        VStack(spacing: 24) {
            // HEADER
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.carbon)
                Spacer()
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
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.secondaryColor.opacity(0.2)) // fondo suave
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
                        .foregroundColor(.primaryColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            }
            .padding(.horizontal)
            
            // PAYMENT METHOD SECTION
            VStack(alignment: .leading, spacing: 8) {
                Text("Payment method")
                    .font(.headline)
                    .foregroundColor(.carbon)
                
                HStack {
                    // Simulación del logo Mastercard con dos círculos superpuestos
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 24, height: 24)
                            .offset(x: -6)
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 24, height: 24)
                            .offset(x: 6)
                            .opacity(0.9)
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
            }
            .padding()
            .background(Color.secondaryColor)
            .cornerRadius(16)
            .padding(.horizontal)

            
            // CARD DETAILS
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "person")
                            .foregroundColor(.primaryColor)
                        Text("Name on the card")
                            .font(.caption)
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                    }
                    Text("Camila Williamson")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "creditcard")
                            .foregroundColor(.primaryColor)
                        Text("Card number")
                            .font(.caption)
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("1234 4564 3333 0329")
                            .font(.subheadline)
                        Spacer()
                        Image("mastercard")
                            .resizable()
                            .frame(width: 40, height: 28)
                    }
                    Divider()
                }
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expiry date")
                            .font(.caption)
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                        Text("06/2023")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CVC")
                            .font(.caption)
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                        Text("333")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            
            Spacer()
            
            // ORDER SUMMARY SECTION
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sub-Total")
                        Text("Delivery Charge")
                        Text("Discount")
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("120 $")
                        Text("10 $")
                        Text("20 $")
                    }
                }
                .foregroundColor(.cream)
                
                Divider()
                    .background(Color.cream)
                
                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text("150 $")
                        .font(.headline)
                }
                .foregroundColor(.cream)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.primaryColor)
                    .overlay(
                        Image("summaryPattern") // Usa tu asset de fondo decorativo
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .opacity(0.2)
                    )
            )
            .padding(.horizontal)
            
            // PLACE ORDER BUTTON
            Button(action: {
                print("Place My Order tapped")
            }) {
                Text("Place My Order")
                    .foregroundColor(.primaryColor)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.cream)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color.cream.edgesIgnoringSafeArea(.all))
    }
}

struct ConfirmOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOrderView()
    }
}
