//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

// MARK: - PlotPoint

public struct PlotPoint: Shape {
  let data: [Double]
  let index: Int
  let size: Double

  public init(data: [Double], index: Int, size: Double = 8) {
    self.data = data
    self.index = index
    self.size = size
  }

  public func path(in rect: CGRect) -> Path {
    guard data.indices.contains(index) else { return Path() }

    let maxY = data.max() ?? 0
    let minY = data.min() ?? 0
    let yAxis: CGFloat = maxY - minY

    let xStep = rect.width / Double(data.count - 1)

    let xCenter = Double(index) * xStep
    let yCenter = (1 - CGFloat((Double(data[index]) - minY) / yAxis)) * rect.height

    var path = Path()
    path.addEllipse(in: .init(x: xCenter - size / 2, y: yCenter - size / 2, width: size, height: size))

    return path
  }
}

// MARK: - PlotPoint_Preview

struct PlotPoint_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      PlotPoint(
        data: [
          1.1,
          2.3,
          3.1,
          4.1
        ],
        index: 1)
    }
    .previewable()
  }
}
