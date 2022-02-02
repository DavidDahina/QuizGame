//
//  ContentView.swift
//  QuizGame
//
//  Created by David Dahina on 12/26/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var quizManager = QuizManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing:20) {
                    Text("QuizGame")
                        .brandedTitle()
                    Text("Are you ready to test your skills?")
                        .foregroundColor(Color("AccentColor"))
                    
                    NavigationLink {
                        QuizView()
                            .environmentObject(quizManager)
                    } label: {
                        PrimaryButton(text: "Let`s go!")
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
