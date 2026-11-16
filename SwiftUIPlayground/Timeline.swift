//
//  Timeline.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/20/23.
//

import UIKit
import SwiftUI

struct Timeline: View {
  let inset: CGFloat = 4.0
  let lineWidth: CGFloat = 3.0
  
  let labelColor = UIColor.label
  
  private var labelFont: UIFont {
    return UIFont.systemFont(ofSize: 8.0, weight: .semibold)
  }
  
  var body: some View {
    GeometryReader { geometry in
      let pathBeginX = inset
      let pathEndX = geometry.size.width - inset
      let pathWidth = pathEndX - pathBeginX
      
      let timeString = "11:00 AM"
      let attributes = [NSAttributedString.Key.foregroundColor: labelColor,
                        NSAttributedString.Key.font: labelFont]
      let timeLabelSize = timeString.size(withAttributes: attributes)

      let sunriseX = pathWidth * CGFloat(0.25)
      let sunsetX = pathWidth * CGFloat(0.75)
      let baselineY = geometry.size.height - (lineWidth * 2 + timeLabelSize.height)
//      let dotDiameter: CGFloat = lineWidth * 3

      let morningLineStart = CGPoint(x: inset, y: baselineY)
      let morningLineEnd = CGPoint(x: sunriseX, y: baselineY)

      let endCurve = CGPoint(x: sunsetX, y: baselineY)
      let eveningLineEnd = CGPoint(x: pathEndX, y: baselineY)
      
      // Calculate day curve
      let curveWidth = endCurve.x - morningLineEnd.x
      let controlPoint1 = CGPoint(x: morningLineEnd.x + curveWidth * 0.25, y: 0)
      let controlPoint2 = CGPoint(x: morningLineEnd.x + curveWidth * 0.75, y: 0)
      
      Path { path in
        path.move(to: morningLineStart)
        path.addLine(to: morningLineEnd)
        
        path.addCurve(to: endCurve, control1: controlPoint1, control2: controlPoint2)
        
        path.addLine(to: eveningLineEnd)
      }
      .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
      .foregroundColor(.primary)
    }
    .frame(maxHeight: 100)
  }
}

struct Timeline_Previews: PreviewProvider {
  static var previews: some View {
    Timeline()
  }
}
