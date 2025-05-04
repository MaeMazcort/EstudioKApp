import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isPasswordVisible: Bool = false
    @State private var isShowingSignUp = false
    @State private var isShowingHome = false  
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                HStack {
                    Text("Sign in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryColor)
                    Spacer()
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        TextField("email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        Image(systemName: "checkmark")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                }
                .padding(.horizontal)

                HStack {
                    Toggle(isOn: $rememberMe) {
                        Text("Remember me")
                            .foregroundColor(.carbon)
                    }
                    .toggleStyle(CheckboxStyle())

                    Spacer()
                    Button("Forgot password?") {
                        // Acción para recuperar contraseña
                    }
                    .foregroundColor(.gray)
                    .font(.subheadline)
                }
                .padding(.horizontal)

                Button(action: {
                    isShowingHome = true
                }) {
                    Text("Sign in")
                        .foregroundColor(.cream)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryColor)
                        .cornerRadius(25)
                        .shadow(color: Color.carbon.opacity(0.2), radius: 5, x: 0, y: 4)
                }
                .padding(.horizontal)

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button(action: {
                        isShowingSignUp = true
                    }) {
                        Text("Sign up")
                            .foregroundColor(.primaryColor)
                            .fontWeight(.semibold)
                    }
                }

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    Text("Or login with")
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                }
                .padding(.horizontal)

                HStack(spacing: 20) {
                    Button {
                        // Acción de Facebook
                    } label: {
                        HStack {
                            Image(systemName: "f.circle.fill")
                                .foregroundColor(.blue)
                            Text("Facebook")
                                .foregroundColor(.carbon)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.secondaryColor.opacity(0.3))
                        .cornerRadius(12)
                    }

                    Button {
                        // Acción de Google
                    } label: {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .foregroundColor(.red)
                            Text("Google")
                                .foregroundColor(.carbon)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.secondaryColor.opacity(0.3))
                        .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .background(Color.cream)
            .navigationDestination(isPresented: $isShowingHome) {
                NavigationBar()  // This will show the NavigationBar with HomeView as the default tab
            }
            .navigationDestination(isPresented: $isShowingSignUp) {
                SignUpView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
       
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(.primaryColor)
                configuration.label
            }
        }
    }
}

#Preview {
    SignInView()
}
