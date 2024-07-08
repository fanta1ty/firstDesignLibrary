//  Created by Thinh Nguyen
//

import SwiftUI

public struct ButtonSize {
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let textSize: Font?

  public init(
    verticalPadding: CGFloat,
    horizontalPadding: CGFloat,
    textSize: Font?
  ) {
    self.verticalPadding = verticalPadding
    self.horizontalPadding = horizontalPadding
    self.textSize = textSize
  }
}
