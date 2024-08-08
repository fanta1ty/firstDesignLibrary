//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

// MARK: - LineChartShape

public struct LineChartShape: Shape {
  let data: [Double]
  let isBackground: Bool

  public init(data: [Double], isBackground: Bool = true) {
    self.data = data
    self.isBackground = isBackground
  }

  public func path(in rect: CGRect) -> Path {
    Path { path in
      for index in data.indices {
        let xPosition: CGFloat = rect.width / CGFloat(data.count - 1) * CGFloat(index)
        let maxY = data.max() ?? 0
        let minY = data.min() ?? 0
        let yAxis: CGFloat = maxY - minY
        let yPosition: CGFloat = (1 - CGFloat((Double(data[index]) - minY) / yAxis)) * rect.height

        if index == 0 {
          path.move(to: .init(x: 0, y: isBackground ? rect.height : yPosition))
        } else {
          path.addLine(to: .init(x: xPosition, y: yPosition))
        }
      }
      if isBackground {
        path.addLine(to: .init(x: rect.width, y: rect.height))
      }
    }
  }
}

// MARK: - LineChartShape_Preview

struct LineChartShape_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      LineChartShape(
        data: [
          1.1,
          2.1,
          3.1,
          4.1
        ],
        isBackground: true
      )
    }
    .previewable()
  }
}
