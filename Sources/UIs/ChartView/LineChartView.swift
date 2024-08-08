//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

// MARK: - LineChartView

public struct LineChartView: View {
  @State private var indicatorValue: Double = 0
  @State private var tapLocation: CGPoint = .zero
  @State private var showVerticalLine: Bool = false
  @EnvironmentObject var themeProvider: ThemeProvider
  @Environment(\.colorScheme) var colorScheme

  let prices: [ChartData]
  let timeline: [String]
  let values: [Double]
  let lineColor: Color
  let size: CGSize
  let onTap: ((Double, String?) -> Void)?
  private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

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
                .fill(.linearGradient(
                  colors: [
                    themeProvider.currentTheme.colors.uiBrand,
                    .clear
                  ],
                  startPoint: .top,
                  endPoint: .bottom
                ))
            )
            .frame(height: size.height)
            .gesture(dragGesture(geometry: geometry))

          if showVerticalLine {
            lighterShape(in: geometry.size)
              .gesture(dragGesture(geometry: geometry))
            verticalLine(in: geometry.size)
          }
        }
      }
      .overlay(alignment: .topTrailing) {
        if showVerticalLine {
          plotPointsView
        }
      }
      .onChange(of: indicatorValue) { _ in
        feedbackGenerator.impactOccurred()
      }
      .frame(height: size.height)
      .padding(.bottom)

      if !timeline.isEmpty {
        HStack {
          ForEach(timeline, id: \.self) { time in
            Text(time)
          }
        }
      }
    }
  }

  private func updateIndicator(geometry: GeometryProxy, value: CGFloat) {
    let index = Int((value / geometry.size.width) * CGFloat(values.count - 1))
    indicatorValue = Double(index)
    tapLocation = CGPoint(x: CGFloat(index) * (geometry.size.width / CGFloat(values.count - 1)), y: 0)
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

  private func lighterShape(in size: CGSize) -> some View {
    let filledColor: Color = colorScheme == .light ? .white.opacity(0.6) : .white.opacity(0.6)
    let suffixValues = Array(values.suffix(from: Int(indicatorValue)))

    return LighterShape(
      tapLocation: tapLocation.x,
      data: suffixValues,
      totalWidth: size.width,
      totalValues: values
    )
    .fill(filledColor)
    .frame(height: size.height)
  }

  private func dragGesture(geometry: GeometryProxy) -> some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { value in
        updateIndicator(geometry: geometry, value: value.location.x)
      }
      .onEnded { _ in
        showVerticalLine = false
      }
  }

  private var plotPointsView: some View {
    ZStack {
      PlotPoint(
        data: values,
        index: Int(indicatorValue),
        size: 20.0
      )
      .fill(lineColor.opacity(0.1))

      PlotPoint(
        data: values,
        index: Int(indicatorValue)
      )
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
      prices: getChartData(),
      timeline: [],
      size: .init(width: 300, height: 300)
    )
    .previewable()
  }
}
