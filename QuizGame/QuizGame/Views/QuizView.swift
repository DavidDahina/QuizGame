//
//  QuizView.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        if quizManager.reachEnd {
            VStack(spacing: 20) {
               Text("Quiz Game")
                    .brandedTitle()
                Text("Congratulations, you completed the game! 🥳")
                Text("You scored\(quizManager.score) out of \(quizManager.lenght)")
                Button {
                    Task.init {
                        await quizManager.fetchQuiz()
                    }
                    
                } label: {
                    PrimaryButton(text: "Play again")
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        } else {
            QuestionView()
                .environmentObject(quizManager)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizManager())
    }
}
