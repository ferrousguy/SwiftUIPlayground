//
//  SettingsMenuView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 8/19/21.
//

import SwiftUI

struct SettingsMenuView: View {
  @Feature(\.isDebugMenuEnabled) var showDebugMenu
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          NavigationLink(destination: Text("Trade Like a Pro")) {
            HStack {
              Text("PRO")
                .font(.caption)
                .bold()
                .foregroundColor(.accentColor)
                .padding(6)
                .background {
                  RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.accentColor.opacity(0.2))
                  
                }
              
              VStack(alignment: .leading) {
                Text("Trade Like a Pro")
                  .font(.headline)
//                  .foregroundColor(.accentColor)
                
                Text("Upgrade now")
                  .font(.subheadline)
              }
              .padding(.vertical)
            }
          }
        }
        
        
        Section {
          Text("Subscription to Elon Musk")
        } header: {
          Text("Following")
        }
        
        Section {
          if showDebugMenu {
            NavigationLink(destination: DebugSettings()) {
              Text("Debug Settings")
            }
          }
        }
      }
      .listStyle(.grouped)
      .navigationTitle("Settings")
    }
  }
}

struct SectionTextAndImage: View {
  var name: String
  var image: String
  
  var body: some View {
    HStack {
      Image(systemName: image)
      
      Text(name)
    }
    .font(.title3)
    .foregroundColor(.accentColor)
  }
}

struct DebugSettings: View {
  var body: some View {
    Text("Debug Settings Menu")
  }
}

struct SettingsMenuView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsMenuView()
  }
}

public class Features: ObservableObject {
  public static let shared = Features()
  private init() {}
  
  @Published public var isDebugMenuEnabled = false
}

@propertyWrapper
public struct Feature<T>: DynamicProperty {
  @ObservedObject private var features: Features
  
  private let keyPath: KeyPath<Features, T>
  
  public init(_ keyPath: KeyPath<Features, T>, features: Features = .shared) {
    self.keyPath = keyPath
    self.features = features
  }
  
  public var wrappedValue: T {
    return features[keyPath: keyPath]
  }
}
