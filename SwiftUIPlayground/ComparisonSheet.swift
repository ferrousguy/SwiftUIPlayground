//
//  ComparisonSheet.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 8/6/25.
//


//
//  ComparizonSheet.swift
//  swiftux-components
//
//  Created by SWIFT UX on 4/11/25.
//  Copyright 2025 SWIFT UX. All rights reserved.
//

import SwiftUI

struct ComparisonSheet: View {
    let icon: Image
    let primaryColor: Color
    let title: String
    let description: String
    let buttonText: String
    let compareCards: [ComparizonCardModel]
    let buttonAction: () -> Void
    
    init(
        icon: Image,
        primaryColor: Color,
        title: String,
        description: String,
        buttonText: String,
        compareCards: [ComparizonCardModel],
        buttonAction: @escaping () -> Void
    ) {
        self.icon = icon
        self.primaryColor = primaryColor
        self.title = title
        self.description = description
        self.buttonText = buttonText
        self.compareCards = compareCards
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                iconPlaceholder(icon: icon, color: primaryColor, size: 40)
                Text(title)
                    .font(.system(.headline, weight: .medium))
                    .foregroundStyle(.primary)
                Text(description)
                    .font(.system(.footnote, weight: .regular))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            ZStack {
                VStack(spacing: 4) {
                    ForEach(compareCards.indices, id: \.self) { index in
                        comparizonCard(model: compareCards[index])
                    }
                }
                
                Image(systemName: "arrow.down")
                    .font(.system(.caption2, weight: .medium))
                    .foregroundStyle(.background)
                    .padding(4)
                    .background(
                        Circle()
                            .fill(primaryColor)
                            .stroke(.background, style: .init(lineWidth: 2))
                    )
                    .frame(width: 20, height: 20)
            }
            
            Button(action: buttonAction) {
                Text(buttonText)
                    .font(.system(.headline, weight: .medium))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(16)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(.background)
    }
    
    @ViewBuilder
    private func comparizonCard(model: ComparizonCardModel) -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text(model.title)
                .font(.system(.subheadline, weight: .medium))
                .foregroundStyle(model.isHighlighted ? primaryColor : .primary)
            Text(model.text)
                .font(.system(.footnote, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(model.isHighlighted ? primaryColor.opacity(0.2) : .gray.opacity(0.1))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func iconPlaceholder(icon: Image, color: Color, size: CGFloat) -> some View {
        icon
            .resizable()
            .foregroundStyle(color)
            .frame(width: size / 2, height: size / 2)
            .padding(10)
            .background(color.opacity(0.2))
            .clipShape(Circle())
            .frame(width: size, height: size)
    }
}

// MARK: - Comparison features model
struct ComparizonCardModel {
    let isHighlighted: Bool
    let title: String
    let text: String
}

// MARK: - Previews
#Preview {
    ComparisonSheet(
        icon: Image(systemName: "clock"),
        primaryColor: .blue,
        title: "Free up more time",
        description: "By switching some of the exercises to myo-reps sets we can shorten your workout",
        buttonText: "Shrink this workout",
        compareCards: [
            .init(isHighlighted: false, title: "Regular sets", text: "60 min workout"),
            .init(isHighlighted: true, title: "Myo-rep sets", text: "45 min workout")
        ],
        buttonAction: {}
    )
    .padding()
}

//
//  ComparisonSheetPreview.swift
//  swiftux-components
//
//  Created by SWIFT UX on 5/10/25.
//  Copyright © 2025 SWIFT UX. All rights reserved.
//

import SwiftUI

struct ComparisonSheetPreview: View {
  @State private var showComparisonSheet: Bool = false
  var body: some View {
    VStack {
      Button {
        showComparisonSheet.toggle()
      } label: {
        HStack {
          Text("Show Info Sheet With Benefits")
          Spacer()
          Image(systemName: "arrow.up.right")
        }
        .foregroundStyle(.foreground)
        .padding(16)
        .background(
          Capsule()
            .stroke(.gray.opacity(0.2), lineWidth: 1)
        )
      }
      .padding(.horizontal, 16)
    }
    .floatingComparisonSheet(isPresented: $showComparisonSheet) {
      ComparisonSheet(
        icon: Image(systemName: "clock"),
        primaryColor: .blue,
        title: "Free up more time",
        description: "By switching some of the exercises to myo-reps sets we can shorten your workout",
        buttonText: "Shrink this workout",
        compareCards: [
          .init(isHighlighted: false, title: "Regular sets", text: "60 min workout"),
          .init(isHighlighted: true, title: "Myo-rep sets", text: "45 min workout")
        ],
        buttonAction: {
          showComparisonSheet.toggle()
        }
      )
    }
  }
}

// MARK: - Previews
#Preview {
  ComparisonSheetPreview()
}

// MARK: - FLoating sheet presentation
struct ComparisonSheetBase {
  var maxDetent: PresentationDetent
  var cornerRadius: CGFloat = 20
  var disableInteractiveDimiss: Bool = true
  var hPadding: CGFloat = 8
  var bPadding: CGFloat = 16
}

extension View {
  @ViewBuilder
  func floatingComparisonSheet<Content: View>(isPresented: Binding<Bool>, config: ComparisonSheetBase = .init(maxDetent: .fraction(0.99)), @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .sheet(isPresented: isPresented) {
        content()
          .background(Color(uiColor: .systemBackground))
          .clipShape(.rect(cornerRadius: config.cornerRadius))
          .padding(.horizontal, config.hPadding)
          .padding(.bottom, config.bPadding)
          .frame(maxHeight: .infinity, alignment: .bottom)
          .presentationDetents([config.maxDetent])
          .presentationCornerRadius(0)
          .presentationBackground(.clear.blendMode(.darken))
          .presentationDragIndicator(.hidden)
          .interactiveDismissDisabled(config.disableInteractiveDimiss)
      }
  }
}
