//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public extension View {
  @ViewBuilder func `if`<Content: View>(
    _ condition: @autoclosure () -> Bool,
    transform: (Self) -> Content
  ) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }

  @ViewBuilder func ifLet<Content: View, O>(
    _ optional: O?,
    transform: (O, Self) -> Content
  ) -> some View {
    if let optional {
      transform(optional, self)
    } else {
      self
    }
  }

  @ViewBuilder func empty(
    if isEmpty: Bool
  ) -> some View {
    if isEmpty {
      EmptyView()
    } else {
      self
    }
  }

  func withoutAnimation(
    _ action: @escaping () -> Void
  ) {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    withTransaction(transaction, action)
  }

  func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(RoundedCorner(
      radius: radius,
      corners: corners
    ))
  }

  func previewable() -> some View {
    modifier(PreviewableModifier())
  }

  func onTapWithHighLight(
    isHaptic: Bool = false,
    hasPressedState: Bool = true,
    onTap: @escaping () -> Void
  ) -> some View {
    modifier(OnTapWithHighlightModifier(
      onTap: onTap,
      isHaptic: isHaptic,
      hasPressedState: hasPressedState
    ))
  }
}
