//
//  FluidNavigationBar.swift
//  swiftux-components
//
//  Created by SWIFT UX on 6/18/25.
//  Copyright © 2025 SWIFT UX. All rights reserved.
//

import SwiftUI

struct FluidNavigationBar<Segment: View>: View {
  @Binding var selectedTab: FluidNavigationBarDestinations
  @Namespace private var animation
  @ViewBuilder var segment: () -> Segment
  var body: some View {
    HStack(spacing: 16) {
      ForEach(FluidNavigationBarDestinations.allCases, id: \.rawValue) { tab in
        Button(action: {
          withAnimation(.snappy(duration: 0.3)) {
            selectedTab = tab
          }
        }, label: {
          HStack(spacing: 6) {
            Image(systemName: tab.icon)
              .foregroundStyle(.gray)
            if selectedTab == tab {
              Text(tab.title)
                .textCase(.uppercase)
                .foregroundStyle(.black.opacity(0.6))
                .transition(.opacity)
            }
          }
          .font(.system(size: 15, weight: .medium))
          .padding(.vertical, 6)
          .padding(.horizontal, 10)
          .foregroundStyle(selectedTab == tab ? .black : .secondary)
          .background {
            if selectedTab == tab {
              segment()
                .matchedGeometryEffect(id: "segment_background", in: animation)
            }
          }
        })
        .buttonStyle(.plain)
      }
    }
  }
}

// MARK: - Navigation Tabs Enum
enum FluidNavigationBarDestinations: Int, CaseIterable {
  case new
  case search
  case subscribed
  case bookmarks
  case settings
  
  var title: String {
    switch self {
      case .new: return "Forecast"
      case .search: return "Search"
      case .subscribed: return "Subscribed"
      case .bookmarks: return "Bookmarks"
      case .settings: return "Settings"
    }
  }
  
  var icon: String {
    switch self {
      case .new: return "chart.bar.horizontal.page"
      case .search: return "magnifyingglass"
      case .subscribed: return "square.grid.2x2.fill"
      case .bookmarks: return "bookmark.fill"
      case .settings: return "gearshape.fill"
    }
  }
}

// MARK: - Scroll Position Enum
enum ScrollPosition: Int, Hashable {
  case new, search, subscribed, bookmarks, settings
}

struct FluidNavigationBarPreview: View {
  @State private var selectedTab = FluidNavigationBarDestinations.new
  @State private var scrollPosition: ScrollPosition?
  @Namespace private var animation
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 0) {
          ForEach(FluidNavigationBarDestinations.allCases, id: \.rawValue) { tab in
            tabContainer()
              .id(ScrollPosition(rawValue: tab.rawValue))
              .containerRelativeFrame(.horizontal)
          }
        }
        .scrollTargetLayout()
      }
      .scrollTargetBehavior(.paging)
      .scrollDisabled(true)
      .scrollPosition(id: $scrollPosition)
      .onChange(of: scrollPosition) { _, newPosition in
        if let newPosition {
          selectedTab = FluidNavigationBarDestinations(rawValue: newPosition.rawValue) ?? .new
        }
      }
      .onChange(of: selectedTab) { _, newTab in
        scrollPosition = ScrollPosition(rawValue: newTab.rawValue)
      }
      .safeAreaInset(edge: .bottom) {
        FluidNavigationBar(selectedTab: $selectedTab) {
          RoundedRectangle(cornerRadius: 12)
            .fill(.gray.opacity(0.1))
            .matchedGeometryEffect(id: "segment_background", in: animation)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(10)
        .background(.ultraThinMaterial.blendMode(.softLight))
      }
    }
  }
  
  @ViewBuilder
  func tabContainer() -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 16) {
        ForEach(0..<20, id: \.self) { _ in
          RoundedRectangle(cornerRadius: 12)
            .fill(.gray.opacity(0.1))
            .frame(height: CGFloat.random(in: 100...200))
        }
      }
      .padding()
    }
  }
}

// MARK: - Previews
#Preview {
  FluidNavigationBarPreview()
}
