//
//  NavigationLinkView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/1/22.
//

import SwiftUI

struct NavigationLinkView: View {
  var body: some View {
//    NavigationView {
      Form {
        Section {
          NavigationLink {
            Text("todo: make a destination view")
          } label: {
            Text("Delete Account")
          }
          
          Text("Another cell")
          
          NavigationLink {
            Text("todo: make a destination view")
          } label: {
            Text("Another cell")
          }

        }
      }
//      .navigationTitle("Settings")
//    }
  }
}

struct NavigationLinkView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationLinkView()
  }
}
