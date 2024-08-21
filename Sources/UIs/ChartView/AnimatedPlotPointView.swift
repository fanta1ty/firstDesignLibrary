//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public struct AnimatedPlotPointView: View {
  @State private var animate: Bool = false
  @EnvironmentObject var themeProvider: ThemeProvider

  private let fillColor: Color
  private let size: CGSize

  init(
    fillColor: Color,
    size: CGSize
  ) {
    self.fillColor = fillColor
    self.size = size
  }

  public var body: some View {
    ZStack {
      Circle()
        .fill(fillColor.opacity(0.2))
        .frame(width: size.width, height: size.height)
        .scaleEffect(animate ? 1.0 : 0.4)
      Circle()
        .fill(fillColor)
        .frame(width: size.width * 0.3, height: size.height * 0.3)
        .scaleEffect(animate ? 1.0 : 0.6)
    }
    .onAppear(perform: {
      animate.toggle()
    })
    .animation(
      .linear(duration: 1)
        .repeatForever(autoreverses: true),
      value: animate
    )
  }
}

#Preview {
  AnimatedPlotPointView(
    fillColor: .red,
    size: .init(width: 30, height: 30)
  )
  .previewable()
}
