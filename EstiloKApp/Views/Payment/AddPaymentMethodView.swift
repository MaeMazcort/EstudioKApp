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

            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Image("card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 220)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image(systemName: "person")
                            .foregroundColor(.primaryColor)
                        Text("Name on the card")
                            .foregroundColor(.primaryColor)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    TextField("Camila Williamson", text: $nameOnCard)
                        .onChange(of: nameOnCard) { newValue in
                            let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }
                            if filtered != newValue {
                                nameOnCard = filtered
                            }
                        }
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image(systemName: "creditcard")
                            .foregroundColor(.primaryColor)
                        Text("Card number")
                            .foregroundColor(.primaryColor)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    TextField("1234 4564 3333 0329", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: cardNumber) { newValue in
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count <= 16 {
                                cardNumber = filtered.chunked(by: 4).joined(separator: " ")
                            } else {
                                cardNumber = String(filtered.prefix(16)).chunked(by: 4).joined(separator: " ")
                            }
                        }
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .foregroundColor(.primaryColor)
                            Text("Expiry date")
                                .foregroundColor(.primaryColor)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        TextField("06/2023", text: $expiryDate)
                            .keyboardType(.numbersAndPunctuation)
                            .onChange(of: expiryDate) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > 6 { expiryDate = String(filtered.prefix(6)) }
                                else if filtered.count > 2 {
                                    expiryDate = "\(filtered.prefix(2))/\(filtered.suffix(from: filtered.index(filtered.startIndex, offsetBy: 2)))"
                                } else {
                                    expiryDate = filtered
                                }
                            }
                            .font(.subheadline)
                            .padding(.vertical, 4)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "lock")
                                .foregroundColor(.primaryColor)
                            Text("CVC")
                                .foregroundColor(.primaryColor)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        TextField("333", text: $cvc)
                            .keyboardType(.numberPad)
                            .onChange(of: cvc) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count <= 3 {
                                    cvc = filtered
                                } else {
                                    cvc = String(filtered.prefix(3))
                                }
                            }
                            .font(.subheadline)
                            .padding(.vertical, 4)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                print("Card added")
            }) {
                Text("Add")
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

extension String {
    func chunked(by length: Int) -> [String] {
        stride(from: 0, to: count, by: length).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: length, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
}

struct AddPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentMethodView()
    }
}
