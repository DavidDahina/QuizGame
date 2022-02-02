//
//  QuestionView.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Quiz Game")
                    .brandedTitle()
                Spacer()
                Text("\(quizManager.index + 1) out of \(quizManager.lenght)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            ProgressBar(progress: quizManager.proggres)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(.system(size:20))
                    .bold()
                    .foregroundColor(.gray)
                ForEach(quizManager.answerChoices, id: \.id ) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }

            }
            
            Button {
                quizManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: quizManager.answerSelected ? Color("AccentColor") : .gray)
            }
            .disabled(!quizManager.answerSelected)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        .navigationBarHidden(true)
    
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(QuizManager())
    }
}
