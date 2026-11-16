//
//  TextFieldExperiments.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 4/3/22.
//

import SwiftUI

struct TextFieldExperiments: View {
  @State private var username: String = ""
  
  var body: some View {
    VStack {
      TextField(
        "Username",
        text: $username,
        onEditingChanged: { (isBegin) in
          if isBegin {
            print("Begins editing")
          } else {
            print("Finishes editing")
          }
        },
        onCommit: {
          print("commit")
        }
      )
    }
  }
}

struct TextFieldExperiments_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldExperiments()
  }
}
