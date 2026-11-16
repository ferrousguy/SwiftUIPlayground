//
//  GrindrButton.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 8/22/25.
//

import SwiftUI
import ViewConfigurable

@ViewConfigurable
public struct GrindrButton: View {
  private let title: String
  private let onAction: () -> Void
  
  private var viewConfig = ViewConfiguration()
  
  struct ViewConfiguration {
    var titleColor: Color = .black
    var backgroundColor: Color = .yellow
    var font: Font = .body
  }
  
  public init(title: String, onAction: @escaping () -> Void) {
    self.title = title
    self.onAction = onAction
  }
  
  public var body: some View {
    Button(action: onAction) {
      Text(title)
        .font(viewConfig.font)
        .foregroundStyle(viewConfig.titleColor)
    }
    .padding()
    .background(viewConfig.backgroundColor)
  }
}

#Preview {
  GrindrButton(title: "Foo", onAction: {})
//    .titleColor(.blue)
//    .backgroundColor(.purple)
//    .font(.callout)
}
