//
//  LazyGridsView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 8/18/21.
//

import SwiftUI

struct LazyVGridView: View {
  var body: some View {
    LazyVGrid(
      columns: [
        GridItem(
          .adaptive(minimum: 80),
          spacing: 16
        )
      ],
      spacing: 16
    ) {
      ForEach(0..<12) { _ in
        Rectangle()
          .fill(Color.blue)
          .frame(height: 100)
      }
    }
    .padding()
  }
}

struct LazyHGridView: View {
  var body: some View {
    LazyHGrid(
      rows: [
        GridItem(
          .adaptive(minimum: 80),
          spacing: 8
        )
      ],
      spacing: 12,
      content: {
        ForEach(0..<12) { _ in
          Rectangle().frame(width: 300)
        }
    })
      .frame(height: 300)
  }
}

struct GridItemDemo: View {
  let rows = [
    GridItem(.fixed(30), spacing: 1),
    GridItem(.fixed(60), spacing: 10),
    GridItem(.fixed(90), spacing: 20),
    GridItem(.fixed(10), spacing: 50)
  ]
  
  let singleRow = [
    GridItem()
  ]
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: rows, spacing: 5) {
        ForEach(0...300, id: \.self) { _ in
          Color.red.frame(width: 30)
          Color.green.frame(width: 30)
          Color.blue.frame(width: 30)
          Color.yellow.frame(width: 30)
        }
      }
    }
  }
}

struct LazyGridsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LazyVGridView()

      LazyHGridView()
      
      GridItemDemo()
    }
  }
}
