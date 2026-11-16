//
//  CardTestView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 12/4/25.
//

import SwiftUI

struct CardTestView: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        Group {
          CrewSection()
          
          CrewSection()
        }
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .overlay {
          RoundedRectangle(cornerRadius: 16.0, style: .continuous)
            .stroke(.quaternary, lineWidth: 1)
        }
        .padding()
      }
    }
  }
}

#Preview {
  CardTestView()
}

struct CrewSection: View {
  var body: some View {
    VStack(alignment: .leading) {
      CardHeader()
        .padding(.top)
        .background(Color.gray.opacity(0.05))
      
      CardContent()
        .padding()
    }
  }
}

struct CardHeader: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Section Title")
        
        Spacer()
      }
      .padding(.horizontal)
      
      Divider()
    }
  }
}

struct CardContent: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack(alignment: .lastTextBaseline) {
        Text("Standard Crew")
          .font(.callout)
        
        Spacer()
        
        Text(3.0, format: .number.precision(.fractionLength(0)))
          .font(.title2.weight(.medium))
      }
    }
  }
}
