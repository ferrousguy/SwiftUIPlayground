//
//  AlignmentGuidesPractice.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/1/22.
//

import SwiftUI

struct AlignmentGuidesPractice: View {
  var body: some View {
    VStack {
      Text("Today's Weather")
        .font(.title)
        .border(.gray)
      
      HStack {
        Text("🌧")
          .alignmentGuide(VerticalAlignment.center) { _ in -20 }
          .border(.gray)
        
        Text("Rain & Thunderstorms")
          .border(.gray)
        
        Text("⛈")
          .alignmentGuide(VerticalAlignment.center) { _ in 20 }
          .border(.gray)
      }
    }
  }
}

struct AlignmentGuidesPractice_Previews: PreviewProvider {
  static var previews: some View {
    AlignmentGuidesPractice()
  }
}
