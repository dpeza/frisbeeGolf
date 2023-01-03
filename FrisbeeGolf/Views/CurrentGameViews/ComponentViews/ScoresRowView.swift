//
//  ScoresRowView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import SwiftUI

struct ScoresRowView: View {
    var item: HoleScoreModel
    var body: some View {
        HStack {
            Text("Hole #\(String(item.hole))").frame(maxWidth: .infinity)
            Spacer()
            Text(Int(item.score) ?? 2 > 0 ? "+\(item.score)" : "\(item.score)").frame(maxWidth: .infinity)
        }
    }
}

struct ScoresRowView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresRowView(item: HoleScoreModel(score: "4", hole: 2))
    }
}


