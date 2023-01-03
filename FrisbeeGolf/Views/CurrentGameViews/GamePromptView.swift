//
//  GamePromptView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import Foundation
import SwiftUI

struct GamePromptView: View {
    @EnvironmentObject var currentScoreModel: CurrentScoreViewModel
    var body: some View {
        Text("Welcome To FrisbeeGolf").offset(y: -60).font(.title)
        Button(currentScoreModel.gameActive ? "Resume Game" : "Start New Game", action: currentScoreModel.startGame)
        Button("Play with friends", action: {})
    }
}

