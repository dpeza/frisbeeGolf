//
//  ContentView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currentScoreModel: CurrentScoreViewModel
    var body: some View {
        NavigationView {
            VStack() {
                
                GameScoreView().opacity(currentScoreModel.gameActive ? 1 : 0)
                GamePromptView().opacity(currentScoreModel.gameActive ? 0 : 1).offset(y:-350)
                
            }.navigationViewStyle(StackNavigationViewStyle()).navigationBarItems(
                leading: Button("Scrap Game", action: currentScoreModel.resetScore).opacity(currentScoreModel.gameActive ? 1 : 0),
                trailing: Button("Save", action: currentScoreModel.saveGame).opacity(currentScoreModel.gameActive ? 1 : 0)
            )
           
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var currentScoreModel: CurrentScoreViewModel = CurrentScoreViewModel()
    static var previews: some View {
        NavigationView {
            ContentView().environmentObject(currentScoreModel)
        }
           
        
        
    }
}
