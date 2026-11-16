//
//  LabelsPracticeView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/20/22.
//

import SwiftUI

// Whichever style a label is rendered, the title is used as a label's description
// (accessibility label). In our case, even a button chooses to show only the heart icon, it
// will read as "favorites button", not "heart button".

// This is also true when labels are used to label other SwiftUI views. Label's title is used
// as a voice-over description (accessibility label) for that particular view even without
// an icon and text. Voice over will describe the Slider in our previous example as
// "Favorites five adjustable".

struct LabelsPracticeView: View {
  var body: some View {
    VStack {
      Label("Favorites", systemImage: "heart")
      // equals to .labelStyle(.automatic)
      
      Label("Favorites", systemImage: "heart")
        .font(.body.bold())
        .symbolVariant(.fill)
        .foregroundColor(.pink)
      
      Label("Favorites", systemImage: "heart")
        .labelStyle(.titleOnly)
      
      Label("Favorites", systemImage: "heart")
        .labelStyle(.iconOnly)
      
      Label("Favorites", systemImage: "heart")
        .labelStyle(.titleAndIcon)
      
      Label("Favorites", systemImage: "heart")
        .labelStyle(AdaptiveLabelStyle())
    }
  }
}

struct AdaptiveLabelStyle: LabelStyle {
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  
  func makeBody(configuration: Configuration) -> some View {
    if verticalSizeClass == .compact {
      // 1
      HStack {
        configuration.icon
        configuration.title
      }
    } else {
      // 2
      VStack {
        configuration.icon
        configuration.title
      }
    }
  }
}

struct LabelsPracticeView_Previews: PreviewProvider {
  static var previews: some View {
    LabelsPracticeView()
.previewInterfaceOrientation(.portrait)
  }
}
