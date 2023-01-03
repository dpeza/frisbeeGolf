//
//  Previous Game Viewer.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import Foundation
import SwiftUI

struct PreviousGameView: View {
    @EnvironmentObject var previousGamesViewModel: PreviousGamesViewModel
    @Binding var tabSelection: Int
    var body: some View {
        VStack {
            Group {
                Text("Previous Games").font(.system(size: 60))
                GamesView(games: previousGamesViewModel.games)
            }.opacity(previousGamesViewModel.games != [] ? 1 : 0).offset(y: 80)
            Group {
                Text("No games saved").font(.title)
                Button("Start a new one", action: {startANewOne()})
            }.opacity(previousGamesViewModel.games != [] ? 0 : 1).offset(y: -450)
            
        }
    }
    func startANewOne() {
        tabSelection = 2
    }
}


struct PreviousGameView_Previews: PreviewProvider {
    static var previousGamesViewModel: PreviousGamesViewModel = PreviousGamesViewModel()
    static var previews: some View {
        NavigationView {
            PreviousGameView(tabSelection: .constant(1)).environmentObject(previousGamesViewModel)
        }
           
        
        
    }
}
