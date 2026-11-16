//
//  LocalizationTestView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/20/22.
//

import SwiftUI

struct LocalizationTestView: View {
  
  // Edit scheme and choose pseudolanguage in options
  
  var body: some View {
    // 1
    NavigationView {
      // 2
      NavigationLink("Test Localization") {
        // 3
        Button(
          action: {},
          label: {
            Label("Hello, world!", systemImage: "globe.americas.fill")
          }
        )
        .buttonStyle(.borderedProminent)
        .font(.largeTitle.bold())
        .padding()
        .toolbar {
          ToolbarItem {
            Button("Edit") {
              
            }
          }
        }
      }
    }
  }
}

struct LocalizationTestView_Previews: PreviewProvider {
  static var previews: some View {
    LocalizationTestView()
  }
}
