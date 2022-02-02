//
//  QuizManager.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import Foundation
import SwiftUI

class QuizManager: ObservableObject {
    
    private (set) var quiz: [Quiz.Result] = []
    @Published private (set) var lenght = 0
    @Published private (set) var index = 0
    @Published private (set) var reachEnd = false
    @Published private (set) var answerSelected = false
    @Published private (set) var question: AttributedString = ""
    @Published private (set) var answerChoices: [Answer] = []
    @Published private (set) var proggres: CGFloat = 0.00
    @Published private (set) var score = 0
    
    
    init() {
        Task.init {
            await fetchQuiz()
        }
    }
    
    func fetchQuiz() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for:urlRequest)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("error fetching data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
           let decodedDate = try decoder.decode(Quiz.self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.proggres = 0.0
                self.reachEnd = false
                
                self.quiz = decodedDate.results
                self.lenght = self.quiz.count
                self.setQuestion()
            }
            
        } catch {
            print("error fetching\(error)")
        }
    }
    
    func goToNextQuestion() {
        if index + 1 < lenght {
            index += 1
            setQuestion()
        } else {
            reachEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        proggres = CGFloat(Double(index+1) / Double(lenght) * 350)
        
        if index < lenght {
            let currentQuizQuestion = quiz[index]
            question = currentQuizQuestion.formattedQuestion
            answerChoices = currentQuizQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
