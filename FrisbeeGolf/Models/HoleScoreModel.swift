//
//  ScoreRowModel.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import Foundation

struct HoleScoreModel: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    let score: String
    let hole: Int
}
