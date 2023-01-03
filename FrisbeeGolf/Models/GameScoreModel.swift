//
//  GameScoreModel.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//
import Foundation

struct GameScoreModel: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    let scores: [HoleScoreModel]
    let title: String
    let date: Date
    let totalScore: Int
}
