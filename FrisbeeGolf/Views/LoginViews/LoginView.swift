//
//  LoginView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/22/22.
//

import Foundation
import SwiftUI



struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    var isSignInButtonDisabled: Bool {
            [email, password].contains(where: \.isEmpty)
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            Text("Login").font(.title).padding(.horizontal).frame(maxWidth: .infinity)
            Spacer()
            TextField("Email",
                      text: $email ,
                      prompt: Text("Login").foregroundColor(.gray)
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)

            HStack {
                Group {
                    if showPassword {
                        TextField("Password",
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.gray))
                    } else {
                        SecureField("Password",
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.gray))
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }

            }.padding(.horizontal)
            HStack {
                Text("Already Have an Account?")
                Button("Login",action: {
                    loginViewModel.switchPages()
                })
            }.padding(.horizontal)
            Spacer()
            Button {
                loginViewModel.logIn(email: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                isSignInButtonDisabled ?
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled)
            .padding()
        
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
