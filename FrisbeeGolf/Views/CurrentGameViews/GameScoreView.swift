//
//  GameScoreView.swift
//  FrisbeeGolf
//
//  Created by Demetrios Pezaris on 12/6/22.
//

import Foundation
import SwiftUI

struct GameScoreView: View {
    @EnvironmentObject var currentScoreModel: CurrentScoreViewModel
    @State var otherVisible: Bool = false
    @State var textInputField: String = ""
    var body: some View {
        Group {
            Text("Total score through \(currentScoreModel.scores.count)").font(.title).offset(y: 20)
            Text(currentScoreModel.totalScore
                 > 0 ? "+\(currentScoreModel.totalScore)" : "\(currentScoreModel.totalScore)").fontWeight(.bold).font(.system(size: 80)).offset(y: 40)
            ScoresView(scores: currentScoreModel.scores)
                .offset(y: 0)
            Spacer()
            Text("Hole #\(currentScoreModel.scores.count + 1)")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    !otherVisible ?
                    AnyView(ForEach(-2...5, id: \.self) {i in
                        Button(i > 0 ? "+\(i)" : "\(i)", action: {
                            currentScoreModel.addHole(score: "\(i)")
                        }).frame(width: 75)
                        Spacer()
                        
                    }) : AnyView(
                        Group{
                            TextField("Score", text: $textInputField).keyboardType(.decimalPad).frame(width: 200).padding(.horizontal)
                            Button("\(otherVisible ? "Enter":"Other")", action: otherButtonPress)
                            Button("Cancel", action: {})
                        }
                        
                    )
                    
                   
                    Spacer()
                }
            }.offset(y: 30)
        }
    }
    func otherButtonPress() {
        if otherVisible == true {
            currentScoreModel.addHole(score: textInputField)
            textInputField = ""
        }
        otherVisible.toggle()
    }
    func cancelButtonPress() {
        if otherVisible == true {
            
        }
    }
}

struct GameScoreView_Previews: PreviewProvider {
    static var currentScoreModel: CurrentScoreViewModel = CurrentScoreViewModel()
    static var previews: some View {
        NavigationView {
            GameScoreView().environmentObject(currentScoreModel)
        }
           
        
        
    }
}
