//
//  UVIndexReadout.swift
//  SwiftUIPlayground
//
//  Created by SWIFT UX on 4/1/25.
//  Adapted by Joben Gohlke for UI Index display on 8/5/25.
//

import SwiftUI

struct UVIndexReadout: View {
  let value: Int
  
  private let barHeight: CGFloat = 30

  private let greenBars = 2
  private let yellowBars = 3
  private let orangeBars = 2
  private let redBars = 3
  private let purpleBars = 1
  
  private var totalBars: Int {
    max(
      value,
      greenBars + yellowBars + orangeBars + redBars + purpleBars
    )
  }
  
  private var valueRisk: String {
    switch value {
      case 0..<3:
        return "Low"
      case 3..<6:
        return "Moderate"
      case 6..<8:
        return "High"
      case 8..<11:
        return "Very high"
      default:
        return "Extreme"
    }
  }
  
  private var riskColor: Color {
    switch value {
      case 0..<3:
        return .green
      case 3..<6:
        return .yellow
      case 6..<8:
        return .orange
      case 8..<11:
        return .red
      default:
        return .purple
    }
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .firstTextBaseline) {
        Text("\(value)")
        
        Text(valueRisk)
          .foregroundStyle(riskColor)
      }
      .font(.headline)
        
      HStack(spacing: 4) {
        ForEach(0..<totalBars, id: \.self) { index in
          RoundedRectangle(cornerRadius: 5)
            .fill(barColor(for: index))
            .frame(height: barHeight)
        }
      }
    }
  }
  
  /// `index` represents the index of the bar to be colored.
  private func barColor(for index: Int) -> Color {
    let baseColor: Color
    /// There are only 11 bars instead of 12 to represent all possible UVIndex values.
    /// The cases are different from risk color to account
    /// for value 0 displaying with all bars dimmed.
    switch index {
      case 0..<2:
        baseColor = .green
      case 2..<5:
        baseColor = .yellow
      case 5..<7:
        baseColor = .orange
      case 7..<10:
        baseColor = .red
      default:
        baseColor = .purple
    }
    return index < value ? baseColor : baseColor.opacity(0.2)
  }
}

// MARK: - Previews
#Preview {
  VStack(spacing: 16) {
    UVIndexReadout(value: 0)
    UVIndexReadout(value: 1)
    UVIndexReadout(value: 2)
    UVIndexReadout(value: 3)
    UVIndexReadout(value: 4)
    UVIndexReadout(value: 5)
    UVIndexReadout(value: 6)
    UVIndexReadout(value: 7)
    UVIndexReadout(value: 8)
    UVIndexReadout(value: 9)
  }
  .padding()
  .preferredColorScheme(.dark)
}

#Preview {
  VStack(spacing: 16) {
    UVIndexReadout(value: 10)
    UVIndexReadout(value: 11)
    UVIndexReadout(value: 12)
    UVIndexReadout(value: 13)
    UVIndexReadout(value: 14)
    UVIndexReadout(value: 26)
  }
  .padding()
  .preferredColorScheme(.dark)
}
