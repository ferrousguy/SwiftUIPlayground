//
//  Card.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 10/4/24.
//

import SwiftUI

struct Card<Content: View>: View {
  @ViewBuilder var content: Content
  
  var body: some View {
    VStack {
      content
    }
    .padding()
    .background(Material.regular, in: .rect(cornerRadius: 8))
    .shadow(radius: 4)
  }
}

struct Carousel<Content: View>: View {
  @ViewBuilder var content: Content
  
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(sections: content) { section in
          VStack {
            section.header
            
            ScrollView(.horizontal) {
              LazyHStack {
                ForEach(section.content) { subview in
                  subview
                    .containerRelativeFrame(.horizontal)
                    .frame(minHeight: 100)
                }
              }
              .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(16)
            
            section.footer
          }
        }
      }
      .scrollTargetLayout()
    }
    .scrollTargetBehavior(.viewAligned)
    .contentMargins(16)
  }
}

struct Magazine<Content: View>: View {
  @ViewBuilder var content: Content
  
  var body: some View {
    ScrollView {
      LazyVStack {
        Group(sections: content) { sections in
          let featured = sections.filter(\.containerValues.isFeatured)
          
          if !sections.isEmpty {
            ForEach(featured) { section in
              section.content.frame(minHeight: 100)
            }
          }
          
          let notFeatured = sections.filter { !$0.containerValues.isFeatured }
          
          ForEach(notFeatured) { section in
            section.header.padding(.top)
            
            ScrollView(.horizontal) {
              LazyHStack {
                section.content
                  .containerRelativeFrame(.horizontal)
                  .frame(minHeight: 100)
              }
            }
            .contentMargins(16)
            
            section.footer
          }
        }
      }
    }
  }
}

extension ContainerValues {
  @Entry var isFeatured = false
}

extension View {
  func featured(_ isFeatured: Bool = true) -> some View {
    containerValue(\.isFeatured, isFeatured)
  }
}

struct ContainerViewExampleView: View {
  //  var body: some View {
  //    Card {
  //      Text("Hello, World!")
  //      Text("My name is Majid Jabrayilov")
  //    }
  //  }
  var body: some View {
    Magazine {
      Section(header: Text("Favorites")) {
        Color.red
        Color.orange
      }
      
      Section {
        Color.green
        Color.yellow
      }
      .featured()
      
      Section(footer: Text("Footer")) {
        Color.blue
        Color.purple
      }
    }
  }
}

#Preview {
  ContainerViewExampleView()
}
