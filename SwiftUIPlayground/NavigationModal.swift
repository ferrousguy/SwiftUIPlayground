//
//  NavigationModal.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/15/23.
//

import Foundation
import SwiftUI

enum PresentationType {
  case push, sheet
}

struct NavigationModal: View {
  @State var presentationType = PresentationType.push
  @State var showChildView = false
  
  func showChildView(as presentationType: PresentationType) -> Binding<Bool> {
    .init(
      get: { self.showChildView && self.presentationType == presentationType },
      set: { self.showChildView = $0 }
    )
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Button(action: {
          self.presentationType = .push
          self.showChildView = true
        }) {
          Text("Present new view as Push")
        }
        Button(action: {
          self.presentationType = .sheet
          self.showChildView = true
        }) {
          Text("Present new view as Sheet")
        }
      }
      .navigationBarTitle("Main view", displayMode: .inline)
      .background(
        NavigationLink(
          destination: ChildView(),
          isActive: self.showChildView(as: .push),
          label: {}
        )
      )
    }
    .sheet(isPresented: self.showChildView(as: .sheet)) {
      ChildView()
    }
  }
}

struct ChildView: View {
  var body: some View {
    ZStack {
      Color.red
      Text("Child view")
    }
  }
}

struct NavigationModal_Previews: PreviewProvider {
  static var previews: some View {
    NavigationModal()
  }
}
