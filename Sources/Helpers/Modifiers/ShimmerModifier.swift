//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - ShimmerModifier

public struct ShimmerModifier: ViewModifier {
  @State private var isInitialState = true
  @Environment(\.layoutDirection) private var layoutDirection

  private let animation: Animation
  private let gradient: Gradient
  private let min: CGFloat
  private let max: CGFloat
  private let shimmerStyle: ShimmerStyle

  var startPoint: UnitPoint {
    if layoutDirection == .rightToLeft {
      return isInitialState ?
        UnitPoint(x: max, y: min) :
        UnitPoint(x: 1, y: 0)
    } else {
      return isInitialState ?
        UnitPoint(x: min, y: min) :
        UnitPoint(x: 1, y: 1)
    }
  }

  var endPoint: UnitPoint {
    if layoutDirection == .rightToLeft {
      return isInitialState ?
        UnitPoint(x: 1, y: 0) :
        UnitPoint(x: min, y: max)
    } else {
      return isInitialState ?
        UnitPoint(x: 0, y: 0) :
        UnitPoint(x: max, y: max)
    }
  }

  public init(
    shimmerStyle: ShimmerStyle = .shimmer
  ) {
    self.shimmerStyle = shimmerStyle
    animation = shimmerStyle.animation
    gradient = shimmerStyle.gradient

    self.min = 0 - shimmerStyle.bandSize
    self.max = 1 + shimmerStyle.bandSize
  }

  public func body(content: Content) -> some View {
    animationView(content: content)
      .onAppear(perform: {
        withAnimation(animation) {
          isInitialState = false
        }
      })
  }

  @ViewBuilder func animationView(
    content: Content
  ) -> some View {
    switch shimmerStyle {
    case .shimmer: shimmerView(content: content)
    case .bling: blingView(content: content)
    }
  }

  func shimmerView(
    content: Content
  ) -> some View {
    content
      .mask(LinearGradient(
        gradient: gradient,
        startPoint: startPoint,
        endPoint: endPoint
      ))
  }

  func blingView(
    content: Content
  ) -> some View {
    ZStack {
      content
      LinearGradient(
        gradient: gradient,
        startPoint: startPoint,
        endPoint: endPoint
      )
    }
    .fixedSize(
      horizontal: false, vertical: true
    )
  }
}

public extension ShimmerModifier {
  static let defaultAnimation = Animation
    .linear(duration: 1.5)
    .delay(0.25)
    .repeatForever(autoreverses: false)

  static let blingAnimation = Animation
    .linear(duration: 1.5)
    .delay(1.5)
    .repeatForever(autoreverses: false)

  static let defaultGradient = Gradient(colors: [
    .black.opacity(0.3),
    .black,
    .black.opacity(0.3),
  ])

  static let blingGradient = Gradient(colors: [
    .white.opacity(0.1),
    .white.opacity(0.25),
    .white.opacity(0.1),
  ])
}

// MARK: - ShimmerModifier_Preview

struct ShimmerModifier_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      Group {
        Text("SwiftUI Shimmer")
        Text("SwiftUI Shimmer")
          .preferredColorScheme(.light)
        Text("SwiftUI Shimmer")
          .preferredColorScheme(.dark)
        VStack(alignment: .leading, content: {
          Text("Loading...")
            .font(.title)
          Text(String(repeating: "Shimmer", count: 12))
            .redacted(reason: .placeholder)
        })
        .frame(maxWidth: 200)
      }
      .padding()
      .shimmering()
      .previewLayout(.sizeThatFits)

      Group {
        Text("Not Loading")
          .loading(active: false)
        Text("Loading")
          .loading(active: true)

        Text("Shimmer Effect")
          .shimmerEffect(active: true)

        Text("Bling Effect")
          .blingEffect(active: true)
      }
    }
      .previewable()
  }
}
