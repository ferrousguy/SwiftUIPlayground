//
//  MeasurementView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 9/25/23.
//

import SwiftUI

struct MeasurementView: View {
  private let windspeed = Measurement<UnitLength>(
    value: 200.0,
    unit: .centimeters
  )
  
  private let formatStyle = Measurement<UnitLength>.FormatStyle(
    width: .abbreviated,
    usage: .asProvided,
    numberFormatStyle: .number
  )
  
  var body: some View {
    Text(windspeed, format: formatStyle)
      .padding()
  }
}

#Preview {
  Group {
    MeasurementView()
      .environment(\.locale, Locale(identifier: "fr"))
    
    MeasurementView()
      .environment(\.locale, Locale(identifier: "ar_MA"))
    
    MeasurementView()
      .environment(\.locale, Locale(identifier: "zh_CN"))
  }
}
