//
//  DrawingPractice.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 6/21/23.
//

import SwiftUI

struct DrawingPractice: View {
  @State var textColor = Color.black
  @State var screenColor = Color.black
  @State var buttonOffset = 0.0
  @State var degreesLoaded = 0.0
  
  var body: some View {
    ZStack {
      DeviceButton(animatableData: buttonOffset).fill(Color.greenishDarker).onTapGesture {
        self.turnScreenOn()
      }
      DeviceBorder().fill(Color.greenish)
      DeviceScreen().fill(screenColor)
      LoadingBar(animatableData: degreesLoaded).stroke(lineWidth: 10).fill(Color.whiteish)
      
      Text("{}").font(.system(size: 100, design: .monospaced)).foregroundColor(textColor)
    }
  }
  
  func turnScreenOn() {
    withAnimation(Animation.linear(duration: 0.1)) {
      self.buttonOffset = 10
    }
    
    withAnimation(Animation.linear(duration: 0.2)) {
      self.buttonOffset = 0
    }
    
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
      withAnimation(Animation.linear(duration: 0.5)) {
        self.degreesLoaded = 360
      }
    }
    
    Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
      self.degreesLoaded = 0
      
      withAnimation {
        self.screenColor = Color.blackish
        self.textColor = Color.whiteish
      }
    }
  }
  
  var exclPoint: some View {
    Path { path in
      path.move(to: CGPoint(x: 50, y: 50))
      path.addLine(to: CGPoint(x: 250, y: 50))
      path.addLine(to: CGPoint(x: 250, y: 250))
      path.addLine(to: CGPoint(x: 50, y: 250))
      
      path.move(to: CGPoint(x: 50, y: 400))
      path.addQuadCurve(
        to: CGPoint(x: 150, y: 300),
        control: CGPoint(x: 50, y: 300)
      )
      path.addQuadCurve(
        to: CGPoint(x: 250, y: 400),
        control: CGPoint(x: 250, y: 300)
      )
      path.addQuadCurve(
        to: CGPoint(x: 150, y: 500),
        control: CGPoint(x: 250, y: 500)
      )
      path.addQuadCurve(
        to: CGPoint(x: 50, y: 400),
        control: CGPoint(x: 50, y: 500)
      )
    }
  }
}

extension Color {
  static let greenish = Color(hue: 166/360, saturation: 0.44, brightness: 0.72)
  static let greenishDarker = Color(hue: 166/360, saturation: 0.44, brightness: 0.60)
  static let whiteish = Color(red: 208/255, green: 208/255, blue: 208/255)
  static let blackish = Color(red: 30/255, green: 32/255, blue: 36/255)
}

struct DeviceBorder: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: 0, y: 50))
    path.addQuadCurve(to: CGPoint(x: 50, y: 0), control: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 300, y: 0))
    path.addQuadCurve(to: CGPoint(x: 350, y: 50), control: CGPoint(x: 350, y: 0))
    path.addLine(to: CGPoint(x: 350, y: 600))
    path.addQuadCurve(to: CGPoint(x: 300, y: 650), control: CGPoint(x: 350, y: 650))
    path.addLine(to: CGPoint(x: 50, y: 650))
    path.addQuadCurve(to: CGPoint(x: 0, y: 600), control: CGPoint(x: 0, y: 650))
    
    let scale = (rect.width / 350) * (9/10)
    let xOffset = (rect.width * (1/10))/2
    let yOffset = (rect.height - 650 * scale) * (1/10) / 2
    
    return path.applying(CGAffineTransform(scaleX: scale, y: scale)).applying(CGAffineTransform(translationX: xOffset, y: yOffset))
  }
}

struct DeviceScreen: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: 20, y: 50))
    path.addQuadCurve(to: CGPoint(x: 50, y: 20), control: CGPoint(x: 20, y: 20))
    
    path.addLine(to: CGPoint(x: 90, y: 20))
    path.addQuadCurve(to: CGPoint(x: 100, y: 30), control: CGPoint(x: 100, y: 20))
    path.addQuadCurve(to: CGPoint(x: 120, y: 50), control: CGPoint(x: 100, y: 50))
    path.addLine(to: CGPoint(x: 230, y: 50))
    path.addQuadCurve(to: CGPoint(x: 250, y: 30), control: CGPoint(x: 250, y: 50))
    path.addQuadCurve(to: CGPoint(x: 260, y: 20), control: CGPoint(x: 250, y: 20))
    
    path.addLine(to: CGPoint(x: 300, y: 20))
    path.addQuadCurve(to: CGPoint(x: 330, y: 50), control: CGPoint(x: 330, y: 20))
    path.addLine(to: CGPoint(x: 330, y: 600))
    path.addQuadCurve(to: CGPoint(x: 300, y: 630), control: CGPoint(x: 330, y: 630))
    path.addLine(to: CGPoint(x: 50, y: 630))
    path.addQuadCurve(to: CGPoint(x: 20, y: 600), control: CGPoint(x: 20, y: 630))
    
    let scale = (rect.width / 350) * (9/10)
    let xOffset = (rect.width * (1/10))/2
    let yOffset = (rect.height - 650 * scale) * (1/10) / 2
    
    return path
      .applying(
        CGAffineTransform(
          scaleX: scale,
          y: scale
        )
      )
      .applying(
        CGAffineTransform(
          translationX: xOffset,
          y: yOffset
        )
      )
  }
}

struct DeviceButton: Shape {
  var animatableData: Double
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.addRoundedRect(
      in: CGRect(
        x: 340 - animatableData,
        y: 160,
        width: 15,
        height: 60
      ),
      cornerSize: CGSize(
        width: 3,
        height: 3
      )
    )
    
    path.addRoundedRect(
      in: CGRect(
        x: -5,
        y: 135,
        width: 15,
        height: 40
      ),
      cornerSize: CGSize(
        width: 3,
        height: 3
      )
    )
    
    path.addRoundedRect(
      in: CGRect(
        x: -5,
        y: 180,
        width: 15,
        height: 40
      ),
      cornerSize: CGSize(
        width: 3,
        height: 3
      )
    )
    
    let scale = (rect.width / 350) * (9/10)
    let xOffset = (rect.width * (1/10))/2
    let yOffset = (rect.height - 650 * scale) * (1/10) / 2
    
    return path
      .applying(
        CGAffineTransform(
          scaleX: scale,
          y: scale
        )
      )
      .applying(
        CGAffineTransform(
          translationX: xOffset,
          y: yOffset
        )
      )
  }
}

struct LoadingBar: Shape {
  var animatableData: Double
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.addArc(center: CGPoint(x: 350/2, y: 730/2), radius: 350/4, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: animatableData), clockwise: false)
    
    let scale = (rect.width / 350) * (9/10)
    let xOffset = (rect.width * (1/10))/2
    let yOffset = (rect.height - 650 * scale) * (1/10) / 2
    
    return path
      .applying(
        CGAffineTransform(
          scaleX: scale,
          y: scale
        )
      )
      .applying(
        CGAffineTransform(
          translationX: xOffset,
          y: yOffset
        )
      )
  }
}

struct DrawingPractice_Previews: PreviewProvider {
  static var previews: some View {
    DrawingPractice()
  }
}
