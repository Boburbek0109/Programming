//
//  RegisterView.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/13/26.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(AuthViewModel.self) private var authVM
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 28) {
                
                VStack(spacing: 12) {
                    Image(systemName: "person.badge.plus.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.blue)
                    
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Sign up to start chatting")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 60)
                
                VStack(spacing: 16) {
                    TextField("Email", text: $email, prompt: Text("Email").foregroundStyle(.blue))
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(10)
                        .background(.gray.opacity(0.12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.blue, lineWidth: 2)
                        }
                    
                    HStack{
                        Group{
                            if showPassword{
                                TextField("Password", text: $password, prompt: Text("Password").foregroundStyle(.red))
                            }else {
                                SecureField("Password", text: $password, prompt: Text("Password").foregroundStyle(.red))
                            }
                        }
                        .textContentType(.newPassword)
                        
                        Button{
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(10)
                    .background(.gray.opacity(0.12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(.red, lineWidth: 2)
                    }
                    
                    HStack{
                        Group{
                            if showConfirmPassword{
                                TextField("Confirm Password", text: $confirmPassword, prompt: Text("Confirm Password")
                                    .foregroundStyle(.red))
                            }else {
                                SecureField("Confirm Password", text: $confirmPassword, prompt: Text("Confirm Password")
                                    .foregroundStyle(.red))
                            }
                        }
                        .textContentType(.newPassword)
                        
                        Button{
                            showConfirmPassword.toggle()
                        } label: {
                            Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(10)
                    .background(.gray.opacity(0.12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(.red, lineWidth: 2)
                    }
                    
                    if !passwordsMatch && !confirmPassword.isEmpty{
                        Text("Passwords do not match")
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                    
                    if let errorMessage = authVM.registerErrorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    
                    Button {
                        Task{
                            await authVM.register(email: email, password: password)
                        }
                    } label: {
                        Text(authVM.isLoading ? "Creating..." : "Create Account")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                    .disabled(!canRegister || authVM.isLoading)
                    .opacity(canRegister && !authVM.isLoading ? 1 : 0.5)
                }
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundStyle(.secondary)
                        
                        Text("Login")
                            .foregroundStyle(.blue)
                    }
                    .font(.callout)
                }
            }
            .padding(.horizontal, 15)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    private var passwordsMatch: Bool{
        password == confirmPassword
    }
    
    private var canRegister: Bool{
        email.contains("@") &&
        password.count >= 8 &&
        !confirmPassword.isEmpty &&
        passwordsMatch
    }
}
 

#Preview {
    RegisterView()
        .environment(AuthViewModel())
}
