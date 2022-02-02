//
//  Extensions.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import Foundation
import SwiftUI

extension Text {
    func brandedTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
