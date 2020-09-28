//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zach McArtor on 9/24/20.
//

import SwiftUI

struct ExampleView: View {
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var score = 0
  
  @State var countries = ["Estonia", "France", "Germany", "Ireland",
                   "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  
  @State var correctAnswer = Int.random(in: 0...2)
  
    var body: some View {
      ZStack {
        
        LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
          .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 20) {
        
          VStack(spacing: 15) {
            Text("Tap the flag of").foregroundColor(.white)
            Text(countries[correctAnswer])
              .font(.largeTitle)
              .fontWeight(.black)
          }.foregroundColor(.white)

          ForEach(0..<3) { number in
            Button(action: {
              flagTapped(number)
            }) { // button image content
              Image(self.countries[number])
                .renderingMode(.original)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                .shadow(color: .black, radius: 2)
            }
          }
          Spacer()
      }
      }.alert(isPresented: $showingScore) {
        Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
          // Body that is executed after tapping dismiss button
          self.askQuestion()
        })
      }
  }
  
  func askQuestion() {
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
  }
  
  func flagTapped(_ number: Int) {
      if number == correctAnswer {
          scoreTitle = "Correct"
          score += 1
      } else {
          scoreTitle = "Wrong"
      }

      showingScore = true
  }
  
}
    
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ExampleView()
  }
}
