import SwiftUI

struct LogInView: View {
    @State private var isShowingSignUp = false
    @State private var isShowingSignIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())

                Image("Tienda")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)

                Spacer()

                Button(action: {
                    isShowingSignIn = true
                }) {
                    HStack {
                        Text("Sign in")
                            .foregroundColor(.cream)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .foregroundColor(.cream)
                    }
                    .padding()
                    .background(Color.brown)
                    .cornerRadius(25)
                    .shadow(radius: 3)
                }
                .padding(.horizontal, 40)

                Button(action: {
                    isShowingSignUp = true
                }) {
                    HStack {
                        Text("Sign up")
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .foregroundColor(.primaryColor)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.primaryColor, lineWidth: 1.5)
                    )
                }
                .padding(.horizontal, 40)

                Spacer()
            }
            .navigationDestination(isPresented: $isShowingSignIn) {
                SignInView()
            }
            .navigationDestination(isPresented: $isShowingSignUp) {
                SignUpView()
            }
            
        }
    }
}

#Preview {
    LogInView()
}
