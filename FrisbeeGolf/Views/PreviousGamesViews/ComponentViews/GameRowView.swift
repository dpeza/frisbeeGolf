//
//  GameRowView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import SwiftUI

struct GameRowView: View {
    var game: GameScoreModel
    var body: some View {
        HStack {
            Text(game.title).frame(maxWidth: .infinity)
            Spacer()
            Text(Int(game.totalScore) > 0 ? "+\(game.totalScore)" : "\(game.totalScore)").frame(maxWidth: .infinity)
        }
    }
}

struct GameRowView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        GameRowView(game: GameScoreModel(scores: [HoleScoreModel(score:"2", hole: 1), HoleScoreModel(score:"3", hole: 2)], title: "My Game", date: date, totalScore: 4))
    }
}


