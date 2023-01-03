//
//  LoginViewModel.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 1/3/23.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
//
//  MainContentViewController.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//
import Combine
class LoginViewModel: ObservableObject {
    
    @Published var loginPageVisible: Bool = false
    @Published var signUpPageVisible: Bool = true
    @Published var isLoggedIn: Bool = false
    let uidKey: String = "UID"
    init () {
        guard
            let data = UserDefaults.standard.data(forKey: "UID"),
            let savedItems = try? JSONDecoder().decode(UIDModel.self, from: data)
        else {return }
        if savedItems.uid != "" && type(of: savedItems.uid) == String.self {
            isLoggedIn = true
            self.signUpPageVisible = false
            self.loginPageVisible = false
        }
    }
       
    private var db = Firestore.firestore()
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let uid: UIDModel = UIDModel(uid: authResult?.user.uid ?? "")
            if let encodedData = try? JSONEncoder().encode(uid) {
                UserDefaults.standard.set(encodedData, forKey: self.uidKey)
            }
            self.signUpPageVisible = false
            self.loginPageVisible = false
            self.isLoggedIn = true
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            let uid: UIDModel = UIDModel(uid: authResult?.user.uid ?? "")
            if let encodedData = try? JSONEncoder().encode(uid) {
                UserDefaults.standard.set(encodedData, forKey: "UID")
            }
            self?.isLoggedIn = true
            self?.signUpPageVisible = false
            self?.loginPageVisible = false
        }
    }
    func switchPages() {
        loginPageVisible.toggle()
        signUpPageVisible.toggle()
    }
    func signOut() {
        let uid: UIDModel = UIDModel(uid: "")
        if let encodedData = try? JSONEncoder().encode(uid) {
            UserDefaults.standard.set(encodedData, forKey: self.uidKey)
        }
        self.loginPageVisible = false
        self.signUpPageVisible = true
        self.isLoggedIn = false
    }
    
    
}

