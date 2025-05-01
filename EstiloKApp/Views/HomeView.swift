import SwiftUI

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var price: String
    var imageName: String
}

struct HomeView: View {
    let popularProducts = [
        Product(name: "Grapeseed Oil", price: "$259.00", imageName: "oil"),
        Product(name: "Bio Shampoo", price: "$310.00", imageName: "shampoo"),
        Product(name: "Beauty Soap", price: "$199.00", imageName: "soap")
    ]
    
    let onSaleProducts = [
        Product(name: "Ceremonia Oil", price: "$153.00", imageName: "ceremonia"),
        Product(name: "Ethique Shampoo", price: "$195.00", imageName: "ethique"),
        Product(name: "TBS Hair Mask", price: "$195.00", imageName: "mask")
    ]
    
    let buyAgain = [
        Product(name: "Livingproof Kit", price: "$259.00", imageName: "kit"),
        Product(name: "Eco Conditioner", price: "$179.00", imageName: "conditioner"),
        Product(name: "Sunflower Serum", price: "$99.00", imageName: "serum")
    ]
    
    let recommended = [
        Product(name: "Eva-Nyc Mask", price: "$120.00", imageName: "eva"),
        Product(name: "ESPA Cream", price: "$145.00", imageName: "espa"),
        Product(name: "Buttah Hair Lotion", price: "$199.00", imageName: "buttah")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome Andrea")
                                .font(.title2)
                                .bold()
                            Text("Limon!")
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title2)
                    }
                    .padding(.horizontal)

                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                        
                        TextField("What can we offer you?", text: .constant(""))
                            .padding(10)
                            .padding(.trailing, 10)
                        
                        Spacer()
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    ZStack {
                        Image("promoBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 120)
                            .clipped()
                            .cornerRadius(20)

                        HStack {
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text("50% off special\ndeal in February")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)

                                Button(action: {
                                }) {
                                    Text("Buy now")
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(15)
                                }
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(height: 150)
                    .padding(.horizontal)

                    // Popular section
                    ProductSection(title: "Popular this week!", products: popularProducts)

                    // On Sale section
                    ProductSection(title: "On Sale", products: onSaleProducts)

                    // Buy again
                    ProductSection(title: "Buy again", products: buyAgain)

                    // Specially for you
                    ProductSection(title: "Specially for you", products: recommended)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProductSection: View {
    let title: String
    let products: [Product]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text("View more")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products) { product in
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image(product.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 120)
                                            .clipped()
                                            .cornerRadius(10)
                                )
                                .cornerRadius(10)
                            Text(product.name)
                                .font(.caption)
                                .lineLimit(2)
                            Text(product.price)
                                .font(.caption)
                                .bold()
                        }
                        .frame(width: 120)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

