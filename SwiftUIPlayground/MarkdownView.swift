//
//  MarkdownView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 3/9/22.
//

import SwiftUI

struct MarkdownView: View {
  
  var markdownFormattedString = "**Hello** ~~*World*~~"
  var attributedString = try! AttributedString(markdown: "Line1 \n*Line2*")
  var attributedStringPreserving = try! AttributedString(
    markdown: "Line1 \nLine2",
    options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
  )
  
  var body: some View {
    VStack {
      Text ("Does not work").foregroundColor(.red)
      
      VStack(alignment: .leading) {
        Text(markdownFormattedString)
        
        Text("\(markdownFormattedString)")
        
        Text(attributedString)
      }.padding()
      
      Text ("Works").foregroundColor(.green)
  
      VStack(alignment: .leading) {
        Text("**Hello** ~~*World*~~")
        
        Text(.init(markdownFormattedString))
        
        Text(attributedStringPreserving)
      }.padding()
    }.font(.system(size: 30, weight: .regular, design: .rounded))
  }
}

struct MarkdownView_Previews: PreviewProvider {
  static var previews: some View {
    MarkdownView()
  }
}
