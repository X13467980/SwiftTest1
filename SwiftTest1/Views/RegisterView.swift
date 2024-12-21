//
//  RegisterView.swift
//  SwiftTest1
//
//  Created by X on 2024/12/19.
//
import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var isSuccess: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
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
                registerUser()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Register")
        .alert(isPresented: $isSuccess) {
            Alert(
                title: Text("Success"),
                message: Text("User registered successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func registerUser() {
        AuthManager.shared.register(email: email, password: password) { result in
            switch result {
            case .success:
                isSuccess = true
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
