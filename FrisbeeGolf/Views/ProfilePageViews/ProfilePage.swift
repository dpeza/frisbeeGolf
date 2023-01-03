//
//  ProfilePage.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 1/3/23.
//

import Foundation
import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        VStack {
            Text("Profile").font(.title)
            Button("Sign Out", action: {loginViewModel.signOut()})
        }
        
    }
}
