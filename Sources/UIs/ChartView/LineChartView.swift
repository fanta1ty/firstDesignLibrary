//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

// MARK: - LineChartView

public struct LineChartView: View {
    @State private var indicatorValue: Double = 0
    @State private var showVerticalLine: Bool = false
    @State private var tapLocation: CGPoint = .zero
    @EnvironmentObject var themeProvider: ThemeProvider

    let prices: [ChartData]
    let timeline: [String]
    let values: [Double]
    let lineColor: Color
    let size: CGSize
    let onTap: ((Double, String?) -> Void)?

    public init(
        prices: [ChartData],
        timeline: [String],
        size: CGSize,
        lineColor: Color = Color(uiColor: .pr600),
        onTap: ((Double, String?) -> Void)? = nil
    ) {
        self.prices = prices
        self.timeline = timeline
        self.values = prices.map { $0.price }
        self.lineColor = lineColor
        self.size = size
        self.onTap = onTap
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Normal Chart
                    LineChartShape(data: values)
                        .stroke(lineColor, style: StrokeStyle(
                            lineWidth: 1,
                            lineCap: .round,
                            lineJoin: .round
                        ))
                        .background(
                            LineChartShape(data: values, isBackground: true)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            themeProvider.currentTheme.colors.uiBrand,
                                            .clear
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )
                        .frame(height: size.height)
                        .gesture(dragGesture(geometrySize: geometry.size))
                        .padding(.bottom)

                    if showVerticalLine {
                        verticalLine(in: geometry.size)
                        lighterRectangle(in: geometry.size)
                            .gesture(dragGesture(geometrySize: geometry.size))
                    }
                }
            }
            .overlay(alignment: .topTrailing) {
                plotPointsOverlay
            }
            .frame(height: size.height)

            if !timeline.isEmpty {
                HStack {
                    ForEach(timeline, id: \.self) { time in
                        Text(time)
                    }
                }
            }
        }
    }

    private func updateIndicator(geometrySize: CGSize, value: CGFloat) {
        let index = Int((value / geometrySize.width) * CGFloat(values.count - 1))
        indicatorValue = Double(index)
        tapLocation = CGPoint(x: CGFloat(index) * (geometrySize.width / CGFloat(values.count - 1)), y: value)
        showVerticalLine = true

        let timelineItem = index < timeline.count ? timeline[index] : nil
        onTap?(values[index], timelineItem)
    }

    private func verticalLine(in size: CGSize) -> some View {
        Path { path in
            path.move(to: .init(x: tapLocation.x, y: 0))
            path.addLine(to: .init(x: tapLocation.x, y: size.height))
        }
        .stroke(lineColor, style: StrokeStyle(
            lineWidth: 1,
            lineCap: .round,
            lineJoin: .round
        ))
    }

    private func lighterRectangle(in size: CGSize) -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.6))
            .frame(width: size.width - tapLocation.x, height: size.height)
            .position(x: tapLocation.x + (size.width - tapLocation.x) / 2, y: size.height / 2)
    }

    private func dragGesture(geometrySize: CGSize) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                updateIndicator(geometrySize: geometrySize, value: value.location.x)
            }
    }

    private var plotPointsOverlay: some View {
        ZStack {
            PlotPoint(data: values, index: Int(indicatorValue), size: 20.0)
                .fill(lineColor.opacity(0.1))
            PlotPoint(data: values, index: Int(indicatorValue))
                .fill(lineColor)
        }
    }
}

// MARK: - LineChartView_Preview

struct LineChartView_Preview: PreviewProvider {
  static func getChartData() -> [ChartData] {
    var chartItems = [ChartData]()
    for _ in 1...20 {
      let chartItem = ChartData(price: Double.random(in: 100...200))
      chartItems.append(chartItem)
    }
    return chartItems
  }

  static func getTimeLine() -> [String] {
    return (2019...2024).map { String($0) }
  }

  static var previews: some View {
    LineChartView(
      prices: getChartData(), timeline: [], size: .init(width: 300, height: 300)
    )
    .previewable()
  }
}
