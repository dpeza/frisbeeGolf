//
//  MainContentViewController.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//

import Foundation
import FirebaseFirestore
class CurrentScoreViewModel: ObservableObject {
    @Published var scores: [HoleScoreModel] = [] {
        didSet {
            saveItems()
        }
    }
    @Published var totalScore: Int = 0
    @Published var gameActive: Bool = false
    @Published var gameTitle: String = "Game"
    let gamesKey: String = "games_list"
    let itemsKey: String = "items_list"
    var userId = ""
    private var db = Firestore.firestore()
    init () {
        getItems()
        getUID()
        var score: Int = 0
        for item in scores {
            score += Int(item.score) ?? 0
        }
        self.totalScore = score
    }
    func addHole(score: String){
        scores.append(HoleScoreModel(score: score, hole: scores.count + 1))
        totalScore += Int(score) ?? 0
    }
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([HoleScoreModel].self, from: data)
        else {return }
        self.scores = savedItems
    }
    func editHole(score: String, hole: Int) {
        scores[hole] = HoleScoreModel(score: score, hole: hole)
    }
    func getUID() {
        guard
            let data = UserDefaults.standard.data(forKey: "UID"),
            let savedItems = try? JSONDecoder().decode(UIDModel.self, from: data)
        else {return }
        self.userId = savedItems.uid
    }
    func resetScore() {
        scores = []
        totalScore = 0
        gameActive = false
        gameTitle = "Game"
    }
    func startGame() {
        gameActive = true
    }
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    func saveGame() {
        var ref: DocumentReference? = nil
        ref = db.collection("games").addDocument(data: [
            "holes":  scores.map({ (hole: HoleScoreModel) -> String in
                hole.score
            }),
            "totalScore": totalScore,
            "user": userId,
            "date": Date(),
            "title": gameTitle,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        resetScore()
    }
}
