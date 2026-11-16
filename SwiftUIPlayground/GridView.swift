//
//  GridView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 5/21/23.
//

import SwiftUI

struct GridView: View {
  var body: some View {
    Grid(alignment: .bottom, horizontalSpacing: 1, verticalSpacing: 1) {
      GridRow {
        Text("Row 1")
        
        ForEach(0..<2) { _ in Color.red }
      }
      
      GridRow {
        Text("Row 2")
        
        ForEach(0..<5) { _ in Color.green }
      }
      
      GridRow {
        Text("Row 3")
        ForEach(0..<4) { _ in Color.blue }
      }
    }
    .padding()
  }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView()
  }
}
