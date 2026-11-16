//
//  GroupBoxTestView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 1/16/25.
//

import SwiftUI

struct GroupBoxTestView: View {
  @State private var userAgreed: Bool = false
  
  var body: some View {
    GroupBox {
      ScrollView(.vertical, showsIndicators: true) {
        Text("Foo bar")
          .font(.footnote)
      }
      .frame(height: 100)
      Toggle(isOn: $userAgreed) {
        Text("I agree to the above terms")
      }
    } label: {
      Label("End-User Agreement", systemImage: "building.columns")
        .foregroundStyle(.red)
    }
    .groupBoxStyle(PinkBorderGroupBoxStyle())
    .padding()
  }
}

struct PinkBorderGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    GroupBox(configuration)
      .border(Color.pink)
      .background(Color.pink.opacity(0.5))
  }
}

#Preview {
  GroupBoxTestView()
}
