//
//  ContentView.swift
//  WeSplit
//
//  Created by Zach McArtor on 9/22/20.
//

import SwiftUI


enum TipPercentages: String, Identifiable, CaseIterable {

  case ten = "10%"
  case fifteen = "15%"
  case twenty = "20%"
  case twentyFive = "25%"
  case zero = "0%"
  
  var id: String { return self.rawValue }
}

struct ContentView: View {
  
  @State private var checkAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage: TipPercentages = .fifteen
  
  // relies on each of the @State properties. These are recomputed with each binding change
  private var amountPerPerson: Double {
    let orderAmount = Double(checkAmount) ?? 0.0
    let peopleCount = numberOfPeople + 2
    
    var tipSelection = 1.0
    
    switch tipPercentage {
      case .zero:
        tipSelection = 0
      case .ten:
        tipSelection = 0.10
      case .fifteen:
        tipSelection = 0.15
      case .twenty:
        tipSelection = 0.20
      case .twentyFive:
        tipSelection = 0.25
    }
    
    let tipValue = orderAmount * tipSelection
    let grandTotal = orderAmount + tipValue
    return grandTotal / Double(peopleCount)
  }
  
    var body: some View {
      
      NavigationView {
        Form {
          
          Section {
            TextField("Bill Amount", text: $checkAmount)
              .keyboardType(.decimalPad)
          }
            
          // We can add headers and footers to sections
          Section(header: Text("How big of a tip?")) {
            Picker("Tip Amount", selection: $tipPercentage) {
              ForEach(TipPercentages.allCases, id: \.self) { tip in
                Text(tip.rawValue)
              }
            }.pickerStyle(SegmentedPickerStyle())
            // WheelPickerStyle is cool too
            
            Picker("Number of people", selection: $numberOfPeople) {
              ForEach(2..<100) {
                Text("\($0) people")
              }
            }
          }
          
          Section {
            Text("$\(amountPerPerson, specifier: "%.2f")")
          }
          
        }.navigationTitle("We Split")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
