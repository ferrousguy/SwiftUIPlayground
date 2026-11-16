//
//  GradientTextView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 2/20/22.
//

import SwiftUI

struct GradientTextView: View {
  
  // Pre-iOS 15
  //  var body: some View {
  //    Text("The Simplicity of Apple.\nIn a credit card.")
  //      .foregroundLinearGradient(
  //        colors: [.red, .blue, .green, .yellow],
  //        startPoint: .leading,
  //        endPoint: .trailing
  //      )
  //      .font(.system(size: 46, weight: .bold))
  //      .multilineTextAlignment(.center)
  //  }
  
  // iOS 15 and forward
  var body: some View {
    Text("The Simplicity of Apple.\nIn a credit card.")
      .font(.system(size: 46, weight: .bold))
      .multilineTextAlignment(.center)
      .foregroundStyle(
        LinearGradient(
          colors: [.orange, .red, .purple, .indigo],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
  }
}

struct GradientTextView_Previews: PreviewProvider {
  static var previews: some View {
    GradientTextView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}

extension Text {
  public func foregroundLinearGradient(
    colors: [Color],
    startPoint: UnitPoint,
    endPoint: UnitPoint
  ) -> some View {
    self.overlay(
      LinearGradient(
        colors: colors,
        startPoint: startPoint,
        endPoint: endPoint
      )
        .mask(self)
    )
  }
}
