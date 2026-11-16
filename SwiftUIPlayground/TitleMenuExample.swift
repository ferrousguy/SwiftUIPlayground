//
//  TitleMenuExample.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/26/23.
//

import SwiftUI

struct TitleMenuExample: View {
  @State private var date = Date.now
  @State private var datePickerShown = false
  
  var body: some View {
    NavigationStack {
      Text(date, style: .date)
        .navigationTitle(Text(date, style: .date))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleMenu {
          Button("Pick another date") {
            datePickerShown = true
          }
        }
        .sheet(isPresented: $datePickerShown) {
          DatePicker(
            "Choose date",
            selection: $date,
            displayedComponents: .date
          )
          .datePickerStyle(.graphical)
          .presentationDetents([.medium])
          .presentationDragIndicator(.visible)
        }
    }
  }
}

struct TitleMenuExamplePreview: PreviewProvider {
  static var previews: some View {
    TitleMenuExample()
  }
}
