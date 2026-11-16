//
//  MenuView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 4/10/23.
//

import SwiftUI

struct MenuView: View {
  var body: some View {
    Text("Hello, World!")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu("menu") {
            Button(role: .none) {
              
            } label: {
              Label("Done", systemImage: "trash")
            }
          }
          .menuStyle(DefaultMenuStyle(bgColor: .gray, textColor: .green))
        }
      }
  }
}

struct DefaultMenuStyle: MenuStyle {
  var bgColor: Color
  var textColor: Color
  
  func makeBody(configuration: Configuration) -> some View {
    Menu(configuration)
      .background(bgColor)
      .foregroundColor(textColor)
  }
}

func testing() {
    print("YOOOOOO")
}

//Image(systemName: "ellipsis.circle")Image(systemName: "doc")
let actions = ["Size1", "Size2", "Size3", "Size4", "Size5", "Size6", "Size7", "Size8", "Size9", "Size10", "Size11", "Size12", "Size13", "Size14", "Size15", "Size16", "Size17"]

struct RedBorderMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .border(Color.red)
    }
}

var age = 0

struct MenuTestView: View {
    var body: some View {
        VStack {
            Menu {
                Button(action: testing) {
                    Label("Create a node", systemImage: "plus")
                }
                Button(action: testing) {
                    Label("Add a file", systemImage: "doc")
                }
                Button("Focus Mode", action: testing)
                Button("Reset Graph", action: testing)
                Button("Full screen", action: testing)
                Divider()
                Button("Rename Project", action: testing)
                Button("Settings", action: testing)
                Menu("Change Type") {
                    Button("Number", action: testing)
                    Button("Text", action: testing)
                    Button("Anchor", action: testing)
                    Button("Size", action: testing)
                    ForEach(actions, id: \.self) { action in
                        Button(action, action: testing)
                    }
                }
            }
        label: {
            Label("", systemImage: "ellipsis.circle")
        }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      MenuTestView()
    }
  }
}
