//
//  ModalDismissView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 5/28/22.
//

import SwiftUI

struct ModalDismissView: View {
  @State private var isShowingCart = false
  
  var body: some View {
    VStack {
      Button(action: { isShowingCart.toggle() }) {
        Text("Add to Cart")
      }
    }
    .sheet(isPresented: $isShowingCart) {
      ModalView()
    }
  }
}

struct ModalView: View {
  // Old way (13/14), Apple deprecated this in 15
//  @Environment(\.presentationMode) var presentationMode
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationView {
      VStack {
        Text("This is a modal view.")
      }
      .navigationTitle("Cart")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button(action: {
            // Old way (13/14)
//            presentationMode.wrappedValue.dismiss()
            dismiss()
          }) {
            Text("Done")
          }
        }
      }
    }
  }
}

struct ModalDismissView_Previews: PreviewProvider {
  static var previews: some View {
    ModalDismissView()
  }
}
