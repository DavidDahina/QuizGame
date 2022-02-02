//
//  Quiz.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import Foundation

struct Quiz: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        // нодо сетить айди внутри замыкания, потму что API не возвращает ID
        var id: UUID {
            UUID()
        }
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        var formattedQuestion: AttributedString {
            do {
                //форматирую вопрсоы(убираю всякие маркадуны)
                return try AttributedString(markdown: question)
            } catch {
                print("Error setting formattedQuestion: \(error)")
                return ""
            }
        }

        var answers: [Answer] {
            do {
                // форматирую ответы
                let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                let incorrects = try incorrectAnswers.map { answer in
                    Answer(text: try AttributedString(markdown: answer), isCorrect: false)
                }
                
                // соединяю массивы с правильными и неправильными ответами
                let allAnswers = correct + incorrects
                
                // Перемещиваю ответы чтоб первый не всегла был правильным
                return allAnswers.shuffled()
            } catch {
                print("Error setting answers: \(error)")
                return []
            }
        }
    }
}
