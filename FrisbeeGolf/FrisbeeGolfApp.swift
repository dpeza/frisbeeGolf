//
//  FrisbeeGolfApp.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth




@main
struct FrisbeeGolfApp: App {
    @StateObject var currentScoreModel: CurrentScoreViewModel = CurrentScoreViewModel()
    @StateObject var previousGamesViewModel: PreviousGamesViewModel = PreviousGamesViewModel()
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @State var tabSelection: Int = 1
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            loginViewModel.isLoggedIn ?
            AnyView( TabView(selection: $tabSelection) {
                ContentView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Score Card")
                            
                    }.environmentObject(currentScoreModel)
                        .frame(maxHeight: .infinity)
                        .tag(1)
                PreviousGameView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Previous Games")
                }.environmentObject(previousGamesViewModel)
                    .tag(2)
                ProfilePage()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                }.environmentObject(loginViewModel)
                    .tag(3)
            }) : AnyView( loginViewModel.loginPageVisible ? AnyView(LoginView().environmentObject(loginViewModel)) :
                   AnyView(SignupView().environmentObject(loginViewModel))
            )
            
           
        }
    }
}

