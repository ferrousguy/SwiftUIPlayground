//
//  LabelExampleView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/20/22.
//  https://sarunw.com/posts/swiftui-label-a-standard-way-to-label-user-interface-items/
//

import SwiftUI

struct LabelExampleView: View {
  // We create a shared label that we'll pass as an argument for each view.
  let favouritesLabel = Label("Favorites", systemImage: "heart")
  
  @State private var isPresented = false
  
  var body: some View {
    TabView {
      NavigationView {
        VStack {
          // A standalone label renders an icon side by side with text.
          favouritesLabel
          
          // A button also uses an icon and text to represent itself.
          Button(
            action: {
              isPresented = true
            },
            label: {
              favouritesLabel
            }
          )
          
          // Toggle renders the label alongside with a switch.
          Toggle(isOn: .constant(true)) {
            favouritesLabel
          }
          
          // Slider doesn't render a label at all.
          Slider(value: .constant(5), in: 0...10) {
            favouritesLabel
          }
        }.toolbar {
          // When used as a toolbar item, the button only uses the icon portion.
          ToolbarItem(placement: .primaryAction) {
            Button(
              action: {},
              label: {
                favouritesLabel
              }
            )
          }
        }
        .confirmationDialog(
          "Test Confirmation",
          isPresented: $isPresented,
          titleVisibility: .visible
        ) {
          // In this context, label only uses text.
          Button(
            action: {},
            label: {
              favouritesLabel
            }
          )
        }
      }.tabItem {
        // Tab item renders both text and image vertically in portrait orientation.
        favouritesLabel
      }
    }
  }
}

struct LabelExampleView_Previews: PreviewProvider {
  static var previews: some View {
    LabelExampleView()
  }
}
