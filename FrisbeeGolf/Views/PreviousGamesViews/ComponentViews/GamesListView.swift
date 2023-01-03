//
//  GamesList.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import SwiftUI

struct GamesView: View {
    @State var games: [GameScoreModel]
    var body: some View {
        List {
            ForEach(games) { value in
                GameRowView(game: value)

            }
        }.listStyle(PlainListStyle())
        
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        GamesView(games: [GameScoreModel(scores: [HoleScoreModel(score:"2", hole: 1), HoleScoreModel(score:"3", hole: 2)], title: "My Game", date: date, totalScore: 4)])
    }
}

