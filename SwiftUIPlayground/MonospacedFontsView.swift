//
//  MonospacedFontsView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 5/28/22.
//

import SwiftUI

struct MonospacedFontsView: View {
  var body: some View {
    VStack {
      VStack {
        Text("12:34:56")
        
        Text("07:18:19")
      }
      .font(.system(size: 72))
      .monospacedDigit()
      
      VStack {
        Text("12:34:56")
        
        Text("07:18:19")
      }
      .font(.system(size: 72, weight: .regular, design: .monospaced))
    }
  }
}

struct MonospacedFontsView_Previews: PreviewProvider {
  static var previews: some View {
    MonospacedFontsView()
  }
}
