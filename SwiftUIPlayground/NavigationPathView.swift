//
//  NavigationPathView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 4/8/23.
//

import SwiftUI

struct NavigationPathView: View {
  @State private var navPath = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $navPath) {
      Button("Jump to random") {
        navPath.append(Int.random(in: 1..<50))
      }
      
      List(1..<50) { i in
        NavigationLink(value: "Row \(i)") {
          Label("Row \(i)", systemImage: "\(i).circle")
        }
      }
      .navigationDestination(for: Int.self) { i in
        Text("Int Detail \(i)")
      }
      .navigationDestination(for: String.self) { i in
        SecondLevelView(navPath: $navPath, number: i)
      }
      .navigationDestination(for: Double.self) { f in
        ThirdLevelView(navPath: $navPath)
      }
      .navigationTitle("Navigation")
    }
  }
}

struct SecondLevelView: View {
  @Binding var navPath: NavigationPath
  let number: String
  
  var body: some View {
    Button {
      navPath.append(4.5)
    } label: {
      Text("Go to level 3")
    }
  }
}

struct ThirdLevelView: View {
  @Binding var navPath: NavigationPath
  
  var body: some View {
    Text("level 3")
  }
}

struct NavigationPathView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationPathView()
  }
}
