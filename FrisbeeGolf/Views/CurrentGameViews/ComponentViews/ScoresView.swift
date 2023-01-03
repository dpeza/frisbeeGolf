//
//  ScoresView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import SwiftUI

struct ScoresView: View {
    var scores: [HoleScoreModel]
    var body: some View {
        List {
            ForEach(scores) { value in
                ScoresRowView(item: value)

            }
        }.listStyle(PlainListStyle())
        
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView(scores: [HoleScoreModel(score:"2", hole: 1), HoleScoreModel(score:"3", hole: 2)])
    }
}

