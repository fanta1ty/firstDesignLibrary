//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - LighterShape

public struct LighterShape: Shape {
  var tapLocation: CGFloat
  var data: [Double]
  var totalWidth: CGFloat
  var totalValues: [Double]

  public func path(in rect: CGRect) -> Path {
    let xStep = totalWidth / CGFloat(totalValues.count - 1)
    let yAxis: CGFloat = (totalValues.max() ?? 0) - (totalValues.min() ?? 0)
    let startX = tapLocation

    var path = Path()
    for (index, value) in data.enumerated() {
      let xPosition = startX + xStep * CGFloat(index)
      let yPosition = (1 - CGFloat((value - (totalValues.min() ?? 0)) / yAxis)) * rect.height

      if index == 0 {
        path.move(to: CGPoint(x: startX, y: rect.height))
      }
      path.addLine(to: CGPoint(x: xPosition, y: yPosition))
    }
    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
    path.addLine(to: CGPoint(x: startX, y: rect.height))
    path.closeSubpath()
    return path
  }
}

// MARK: - LighterShape_Preview

#Preview {
  LighterShape(
    tapLocation: 0.3,
    data: [
      1.1,
      2.1,
      3.1,
      4.1
    ],
    totalWidth: 30,
    totalValues: [
      1.1,
      2.1,
      3.1,
      4.1
    ]
  )
  .previewable()
}
