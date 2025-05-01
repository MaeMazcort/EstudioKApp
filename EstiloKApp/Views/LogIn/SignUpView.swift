import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct UserData {
    var firstName: String = ""
    var email: String = ""
    var password: String = ""
    var age: Int = 0
}


struct SignUpView: View {
    @State public var user = UserData()
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isShowingSignIn = false
    
    public var databaseRef: DatabaseReference = Database.database().reference()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Sign up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryColor)

                    VStack(spacing: 16) {
                        FormTextField(label: "Name", text: $user.firstName)
                        FormTextField(label: "Email", text: Binding(
                            get: { user.email },
                            set: { user.email = $0.lowercased() }
                        ))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        FormSecureField(label: "Password", text: $user.password)
                        FormSecureField(label: "Confirm Password", text: $confirmPassword)
                    }
                    .padding(.horizontal, 32)

                    Button(action: registerUser) {
                        Text("Sign up")
                            .foregroundColor(.cream)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.carbon)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal, 32)

                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Button("Sign in") {
                            isShowingSignIn = true
                        }
                        .foregroundColor(.primaryColor)
                    }
                    .navigationDestination(isPresented: $isShowingSignIn) {
                        SignInView()
                    }
                    .navigationBarBackButtonHidden(true)
                    HStack {
                        Text("Or Sign up with")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 32)

                    HStack(spacing: 20) {
                        SocialButton(icon: "f.circle.fill", text: "Facebook", color: .blue)
                        SocialButton(icon: "g.circle.fill", text: "Google", color: .red)
                    }

                    Text("By signing up you agree with our ")
                        .foregroundColor(.gray)
                    + Text("T&C").foregroundColor(.primaryColor).bold()
                    + Text(" and ")
                    + Text("privacy policy").foregroundColor(.mustardYellow).bold()

                    Spacer()
                }
                .padding(.top, 40)
            }
            .background(Color.cream)
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
        .accentColor(.primaryColor)
    }
        
    private func registerUser() {
        guard !user.password.isEmpty, user.password == confirmPassword else {
            alertMessage = "Passwords don't match"
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            guard let userID = authResult?.user.uid else { return }
            
            let userData = [
                "firstName": user.firstName,
                "email": user.email
            ]

            databaseRef.child("users").child(userID).setValue(userData) { error, _ in
                if let error = error {
                    alertMessage = "Database error: \(error.localizedDescription)"
                    showAlert = true
                }
            }
            
        }
    }
}

// MARK: - UI Components

struct FormTextField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(label, text: $text) 
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
        }
    }
}
struct FormSecureField: View {
    let label: String
    @Binding var text: String
    @State private var isVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Group {
                    if isVisible {
                        TextField("Enter password", text: $text)
                    } else {
                        SecureField("Enter password", text: $text)
                    }
                }
                Button(action: { isVisible.toggle() }) {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
        }
    }
}

struct SocialButton: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        Button {
            // Acción social
        } label: {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(text)
                    .foregroundColor(.carbon)
            }
            .frame(minWidth: 120)
            .padding(.vertical, 12)
            .background(Color.secondaryColor.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
#Preview {
    SignUpView()
}
