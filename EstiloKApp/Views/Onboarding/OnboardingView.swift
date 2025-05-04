import SwiftUI

struct OnboardingView: View {
    @State private var selection = 0
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selection) {
                    OnboardingPage(
                        imageName: "ek_logo",
                        title: "Your next style lies here",
                        description: "Create appointments to get your next style in Estudio K"
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        imageName: "ek_logo",
                        title: "Find products you'll be proud to use",
                        description: "We offer a wide variety of sustainable beauty products"
                    )
                    .tag(1)
                    
                    OnboardingPage(
                        imageName: "delivery_image",
                        title: "Discover new opportunities",
                        description: "Use our networking platform to find jobs, courses and new ways to grow"
                    )
                    .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        if index == selection {
                            Capsule()
                                .frame(width: 20, height: 8)
                                .foregroundColor(.primaryColor)
                        } else {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.secondaryColor.opacity(0.7))
                        }
                    }
                }
                .padding(.top, 16)
                .animation(.easeInOut(duration: 0.3), value: selection)
                
                Spacer()
                
                Button(action: {
                    if selection < 2 {
                        selection += 1
                    } else {
                        navigateToHome = true
                    }
                }) {
                    Text(selection < 2 ? "Continue" : "Get started")
                        .foregroundColor(.cream)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.carbon)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                if selection < 2 {
                    Button("Skip") {
                        navigateToHome = true
                    }
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                }
                
                Spacer()
                    .frame(height: 20)
                
                // 👇 Esto permite la navegación programática
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            .background(Color.cream.edgesIgnoringSafeArea(.all))
        }
    }
}

struct OnboardingPage: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()
            
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primaryColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Spacer()
        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
