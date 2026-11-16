//
//  TempBar.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 7/15/23.
//

import SwiftUI

struct TempBar: View {
  let lineWidth: CGFloat = 16.0
  let minTemp: Measurement<UnitTemperature> = .init(value: 29.0, unit: .fahrenheit)
  let maxTemp: Measurement<UnitTemperature> = .init(value: 95.0, unit: .fahrenheit)
  let minWeeklyTemp: Measurement<UnitTemperature> = .init(value: 23.0, unit: .fahrenheit)
  let maxWeeklyTemp: Measurement<UnitTemperature> = .init(value: 105.0, unit: .fahrenheit)
  
  var gradientColors: [Color] {
    var colors: Set<Color> = [.blue, .teal, .green, .yellow, .orange, .red]
    if minTemp > Measurement(value: 33.0, unit: .fahrenheit) {
      colors.remove(.blue)
    }
    if minTemp > Measurement(value: 50, unit: .fahrenheit) {
      colors.remove(.teal)
    }
    if minTemp > Measurement(value: 62, unit: .fahrenheit) {
      colors.remove(.green)
    }
    if minTemp > Measurement(value: 73, unit: .fahrenheit) {
      colors.remove(.yellow)
    }
    if minTemp > Measurement(value: 90, unit: .fahrenheit) {
      colors.remove(.orange)
    }
    
    if maxTemp < Measurement(value: 90, unit: .fahrenheit) {
      colors.remove(.red)
    }
    if maxTemp < Measurement(value: 74, unit: .fahrenheit) {
      colors.remove(.orange)
    }
    if maxTemp < Measurement(value: 63, unit: .fahrenheit) {
      colors.remove(.yellow)
    }
    if maxTemp < Measurement(value: 51, unit: .fahrenheit) {
      colors.remove(.green)
    }
    if maxTemp < Measurement(value: 33, unit: .fahrenheit) {
      colors.remove(.teal)
    }
    
    print("colored set: \(colors)")
        
    var orderedColors: [Color] = []
    if colors.contains(.blue) {
      orderedColors.append(.blue)
    }
    
    if colors.contains(.teal) {
      orderedColors.append(.teal)
    }
    
    if colors.contains(.green) {
      orderedColors.append(.green)
    }
    
    if colors.contains(.yellow) {
      orderedColors.append(.yellow)
    }
    
    if colors.contains(.orange) {
      orderedColors.append(.orange)
    }
    
    if colors.contains(.red) {
      orderedColors.append(.red)
    }
    
    print("ordered colors \(orderedColors)")
    
    return orderedColors
  }
  
  var body: some View {
    GeometryReader { geometry in
      let pathWidth = geometry.size.width
      
      let tempSpread = maxWeeklyTemp.value - minWeeklyTemp.value
      let distanceFromMin = minTemp.value - minWeeklyTemp.value
      let distanceFromMax = maxWeeklyTemp.value - maxTemp.value
      let percentMin = distanceFromMin / tempSpread
      let percentMax = distanceFromMax / tempSpread
      
      let startX = CGFloat(pathWidth * percentMin)
      let endX = CGFloat(pathWidth - (pathWidth * percentMax))
      
      let baselineY = lineWidth / 2.0
      
      Path { path in
        path.move(to: CGPoint(x: 0, y: baselineY))
        path.addLine(to: CGPoint(x: geometry.size.width, y: baselineY))
      }
      .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
      .foregroundColor(.init(white: 0.9))
      
      Path { path in
        path.move(to: CGPoint(x: startX, y: baselineY))
        path.addLine(to: CGPoint(x: endX, y: baselineY))
      }
      .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
      .foregroundStyle(.linearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing))
    }
    .frame(maxWidth: 150, maxHeight: lineWidth)
    .background(.red)
  }
}

struct TempBar_Previews: PreviewProvider {
  static var previews: some View {
    TempBar()
  }
}

// .blue: < 33
// .teal: 33 < temp < 50
// .green: 51 < temp < 62
// .yellow: 63 < temp < 73
// .orange: 74 < temp < 90
// .red: > 90
