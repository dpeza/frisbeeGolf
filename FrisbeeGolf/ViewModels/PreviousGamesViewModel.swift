//
//  PreviousGamesViewModel.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import Foundation
import FirebaseFirestore
//
//  MainContentViewController.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/4/22.
//
import Combine
class PreviousGamesViewModel: ObservableObject {
    
    @Published var games: [GameScoreModel] = []
    //var subscriptions = Set<AnyCancellable>()
    //let gamesKey: String = "games_list"
    var userId = ""
    init () {
        /*
        UserDefaults.standard
            .publisher(for: \.savedGames)
            .handleEvents(receiveOutput: { savedGames in
                self.games = savedGames
            })
            .sink { _ in }
            .store(in: &subscriptions)
         */
        getUID()
        fetchData()
    }
       
    private var db = Firestore.firestore()
    func getUID() {
        guard
            let data = UserDefaults.standard.data(forKey: "UID"),
            let savedItems = try? JSONDecoder().decode(UIDModel.self, from: data)
        else {return }
        self.userId = savedItems.uid
    }
    func fetchData() {
        db.collection("games").whereField("user", isEqualTo: userId).addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
               print("No documents")
               return
           }
           self.games = documents.map { (queryDocumentSnapshot) -> GameScoreModel in
               let data = queryDocumentSnapshot.data()
               let holes = data["holes"] as? [String] ?? [""]
               let title = data["title"] as? String ?? ""
               let date = data["date"] as? Date ?? Date()
               let totalScore = data["totalScore"] as? Int ?? 0
               var i = 0
               let scores = holes.map {(hole) -> HoleScoreModel in
                   i += 1
                   return HoleScoreModel(score: hole, hole: i)
               }
               return GameScoreModel(scores: scores, title: title, date: date, totalScore: totalScore)
           }
            print(self.games)
       }
   }
}

