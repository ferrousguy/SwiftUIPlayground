//
//  CustomAlignmentView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/16/24.
//

import SwiftUI

struct CustomAlignmentView: View {
  @State private var counter = Date()
  
  var body: some View {
    VStack(alignment: .customCenter) {
      Text("Timer")
        .font(.title)
        .frame(maxWidth: .infinity)
      
      HStack(spacing: 16) {
        Text(
          counter.formatted(
            .iso8601.time(
              includingFractionalSeconds: true
            )
          )
        )
        .font(Font.system(.body, design: .monospaced))
        .alignmentGuide(.customCenter) {
          $0[HorizontalAlignment.center]
        }
        
        Button(role: .destructive) {
          counter = Date()
        } label: {
          Image(systemName: "gobackward")
            .imageScale(.large)
        }
        .buttonStyle(.borderedProminent)
      }
    }
  }
}

struct CustomCenter: AlignmentID {
  static func defaultValue(in context: ViewDimensions) -> CGFloat {
    context[HorizontalAlignment.center]
  }
}

extension HorizontalAlignment {
  static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
}

#Preview {
  CustomAlignmentView()
}
