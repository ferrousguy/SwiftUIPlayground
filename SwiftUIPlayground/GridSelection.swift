//
//  GridSelection.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 5/21/23.
//

import SwiftUI

enum Items: String, CaseIterable, Equatable {
  case item1
  case item2
  case item3
  case item4
  case item5
  case item6
}

struct GridPicker: View {
  var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  @State  var selectedItems: [Items] = []
  
  
  var body: some View {
    NavigationView {
      ScrollView(.horizontal) {
        LazyHGrid(rows: rows) {
          ForEach(Items.allCases, id: \.self) { item in
            GridColumn(item: item, items: $selectedItems)
          }
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    
  }
}

struct GridPicker_Previews: PreviewProvider {
  static var previews: some View {
    GridPicker()
  }
}


struct GridColumn:View {
  let item: Items
  
  @Binding var items: [Items]
  
  var body: some View {
    Button(action: {
      if items.contains(item) {
        items.removeAll { $0 == item}
      } else {
        items.append(item)
      }
    }, label: {
      Text(item.rawValue)
        .tag(item)
        .foregroundColor(items.contains(item) ? .purple : .white)
    })
    
    .frame(width: 85, height: 85)
    .background(items.contains(item) ? Color.white : Color.purple)
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
}
