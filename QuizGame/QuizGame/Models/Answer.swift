//
//  Answer.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
