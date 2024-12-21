//
//  LoginView.swift
//  SwiftTest1
//
//  Created by X on 2024/12/19.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                loginUser()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Login")
        .alert(isPresented: $isLoggedIn) {
            Alert(
                title: Text("Success"),
                message: Text("Logged in successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func loginUser() {
        AuthManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success:
                isLoggedIn = true
                errorMessage = nil
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    WelcomeView()
}
