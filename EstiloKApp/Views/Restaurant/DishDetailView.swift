import SwiftUI

struct DishDetailView: View {
    let dish: Dish

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Imagen
                Image("restaurant1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(16)

                // Nombre y calorías
                VStack(alignment: .leading, spacing: 8) {
                    Text(dish.name)
                        .font(.largeTitle.bold())
                        .foregroundColor(.primaryColor)

                    Text("\(dish.calories) kcal")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("$\(String(format: "%.2f", dish.price))")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primaryColor)
                }
                .padding(.horizontal)

                // Descripción placeholder
                VStack(alignment: .leading, spacing: 6) {
                    Text("Description")
                        .font(.title3.bold())
                        .foregroundColor(.primaryColor)

                    Text("A delicious and traditional dish made with fresh local ingredients. Perfectly seasoned and beautifully presented.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Ingredientes (mock)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ingredients")
                        .font(.title3.bold())
                        .foregroundColor(.primaryColor)

                    ForEach(["Tomato", "Onion", "Cilantro", "Tortilla", "Pineapple"], id: \ .self) { ingredient in
                        Text("• \(ingredient)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle(dish.name)
        .accentColor(.primaryColor)
    }
}

#Preview {
    DishDetailView(dish: Dish(name: "Tacos al Pastor", calories: 450, price: 14.99))
}
