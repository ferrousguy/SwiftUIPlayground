//
//  MaterialTest.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 5/15/23.
//

import SwiftUI

struct MaterialTest: View {
  @State private var isShowingModal: Bool = false
  
  var body: some View {
    ZStack {
      Color.red.ignoresSafeArea()
      
      Label("Flag", systemImage: "flag.fill")
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
          isShowingModal.toggle()
        }
    }
    .sheet(isPresented: $isShowingModal) {
      ModalMaterialTest()
    }
  }
}

struct ModalMaterialTest: View {
  var body: some View {
    VStack {
      Text("This is some text.")
    }
    .background(.regularMaterial)
  }
}

struct MaterialTest_Previews: PreviewProvider {
  static var previews: some View {
    MaterialTest()
  }
}
