//  Created by Thinh Nguyen
//

import SwiftUI

public struct HighlightedTextView: View {
  let text: String
  let textFont: Font
  let textColor: Color

  let highlight: String
  let highlightFont: Font
  let highlightColor: Color

  let additionalHighlight: String?
  let additionalHighlightFont: Font?
  let additionalHighlightColor: Color?

  public init(
    text: String,
    textFont: Font,
    textColor: Color,
    highlight: String,
    highlightFont: Font,
    highlightColor: Color,
    additionalHighlight: String?,
    additionalHighlightFont: Font?,
    additionalHighlightColor: Color?
  ) {
    self.text = text
    self.textFont = textFont
    self.textColor = textColor
    self.highlight = highlight
    self.highlightFont = highlightFont
    self.highlightColor = highlightColor
    self.additionalHighlight = additionalHighlight
    self.additionalHighlightFont = additionalHighlightFont
    self.additionalHighlightColor = additionalHighlightColor
  }

  public var body: some View {
    var attributedString = AttributedString(text)
    attributedString.font = textFont
    attributedString.foregroundColor = textColor

    if let range = attributedString.range(of: highlight) {
      attributedString[range].font = highlightFont
      attributedString[range].foregroundColor = highlightColor
    }

    if let additionalHighlight {
      if let range = attributedString.range(of: additionalHighlight) {
        attributedString[range].font = additionalHighlightFont
        attributedString[range].foregroundColor = additionalHighlightColor
      }
    }

    return Text(attributedString)
  }
}

struct HighlightedTextView_Preview: PreviewProvider {
  static var previews: some View {
    HighlightedTextView(
      text: "Highlighted Text View",
      textFont: .body,
      textColor: .red,
      highlight: "Highlighted",
      highlightFont: .largeTitle,
      highlightColor: .blue,
      additionalHighlight: "Additional Highlight",
      additionalHighlightFont: .callout,
      additionalHighlightColor: .accentColor
    ).previewable()
  }
}
