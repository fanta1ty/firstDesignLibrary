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

extension View {
  func addOpacityAnimation(
    opacityManager: OpacityAnimationManager,
    duration: CGFloat = 0,
    delay: CGFloat = 0
  ) -> some View {
    modifier(AnimationModifier(
      manager: opacityManager,
      duration: duration,
      delay: delay
    ))
  }

  func addParallaxMotion(
    manager: MotionManager,
    magnitude: CGFloat
  ) -> some View {
    modifier(
      ParallaxMotionModifier(
        manager: manager,
        magnitude: magnitude
      )
    )
  }
}

extension View {
  func config(
    for type: RowTextType,
    in theme: any TTheme
  ) -> some View {
    modifier(RowTextModifier(type: type, theme: theme))
  }
}

extension View {
  func presentationBackground(
    color: Color
  ) -> some View {
    modifier(PresentationBackgroundModifier(color: color))
  }
}
