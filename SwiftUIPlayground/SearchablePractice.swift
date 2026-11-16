//
//  SearchablePractice.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/11/22.
//

import SwiftUI

struct SearchablePractice: View {
  let colors = ["Blue", "Cyan", "Teal", "Mint", "Green", "Yellow", "Orange", "Red", "Pink", "Purple", "Indigo"]
  
  var filteredColors: [String] { // 1
    if queryString.isEmpty {
      return colors
    } else {
      return colors.filter { $0.localizedCaseInsensitiveContains(queryString) }
    }
  }
  
  @State private var queryString = ""
  
  var body: some View {
    NavigationView {
      List(filteredColors, id: \.self) { color in // 2
        Text(color)
      }
      .navigationTitle("Colors")
    }
    .searchable(text: $queryString, prompt: "Color Search")
  }
}

struct SearchablePractice_Previews: PreviewProvider {
  static var previews: some View {
    SearchablePractice()
  }
}
