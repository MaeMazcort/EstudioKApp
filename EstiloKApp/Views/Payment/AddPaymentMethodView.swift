import SwiftUI

struct AddPaymentMethodView: View {
    @State private var nameOnCard = ""
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvc = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                Text("Add a payment method")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)

            // Form fields
            VStack(alignment: .leading, spacing: 20) {
                // Card preview usando una imagen fija
                Image("card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Name on the card")
                        .foregroundColor(.primaryColor)
                        .font(.caption)
                        .fontWeight(.semibold)
                    TextField("Camila Williamson", text: $nameOnCard)
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Card number")
                        .foregroundColor(.primaryColor)
                        .font(.caption)
                        .fontWeight(.semibold)
                    TextField("1234 4564 3333 0329", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Expiry date")
                            .foregroundColor(.primaryColor)
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("06/2023", text: $expiryDate)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.subheadline)
                            .padding(.vertical, 4)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("CVC")
                            .foregroundColor(.primaryColor)
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("333", text: $cvc)
                            .keyboardType(.numberPad)
                            .font(.subheadline)
                            .padding(.vertical, 4)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Next button
            Button(action: {
                print("Next tapped")
            }) {
                Text("Next")
                    .foregroundColor(.cream)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.carbon)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
        .background(Color.cream.edgesIgnoringSafeArea(.all))
    }
}

struct AddPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentMethodView()
    }
}
