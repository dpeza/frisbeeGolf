
//  LoginView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/22/22.
//

import Foundation
import SwiftUI



struct SignupView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showPassword: Bool = false
    @EnvironmentObject var LoginViewModel: LoginViewModel
    var isSignUpButtonDisabled: Bool {
        !(passwordsMatch && isValidEmail)
    }
    var passwordStrength: Bool {
        let passwordRegEx = "[A-Z0-9a-z._%+-]{8,20}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    var passwordsMatch: Bool {
        ![confirmPassword, password].contains(where: \.isEmpty) && password == confirmPassword
    }
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            Text("Sign Up")
                .font(.title)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            Spacer()
            TextField("Email",
                      text: $email ,
                      prompt: Text("Email").foregroundColor(.gray)
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }.padding(.horizontal)
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
                Group {
                    if showPassword {
                        TextField("Conrim Password",
                                    text: $confirmPassword,
                                    prompt: Text("Password").foregroundColor(.gray))
                    } else {
                        SecureField("Confirm",
                                    text: $confirmPassword,
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
                    LoginViewModel.switchPages()
                })
            }.padding(.horizontal)
            Spacer()
            Button {
                LoginViewModel.createAccount(email: email, password: password)
            } label: {
                Text("Sign Up")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                isSignUpButtonDisabled ?
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignUpButtonDisabled)
            .padding()
        
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
