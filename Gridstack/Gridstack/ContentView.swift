//
//  ContentView.swift
//  Gridstack
//
//  Created by Zach McArtor on 10/10/20.
//

import SwiftUI

// Custom view modifier to turn text blue and BIG

struct BigBlue : ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

extension View {
  
  public func bigblue() -> some View {
    return self.modifier(BigBlue())
  }
  
}


// Our custom container view

struct Gridstack<Content: View>: View {
  
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content // always produces this type of view.
  
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 8) {
      ForEach(0..<rows, id: \.self) { row in
        // start at each row, and populate crosswise in an HStack
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            self.content(row, column)
          }
        }
      }
    }
  }
}

struct ContentView: View {
    var body: some View {
      Gridstack(rows: 4, columns: 2) { row, column in
        VStack(alignment: .leading, spacing: 8) {
          Text("R: \(row) C: \(column)")
          Image(systemName: "\(row * 4 + column).circle")
        }.bigblue()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
