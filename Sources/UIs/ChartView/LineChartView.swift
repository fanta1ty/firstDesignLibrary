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

    private let prices: [ChartData]
    private let timeline: [String]
    private let values: [Double]
    private let lineColor: Color
    private let lineWidth: CGFloat
    private let verticalLineWidth: CGFloat
    private let size: CGSize
    private let showTimeLine: Bool
    private let onTap: ((Double, String?) -> Void)?
    private let onEnd: (() -> Void)?
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    public init(
        prices: [ChartData],
        timeline: [String],
        showTimeLine: Bool,
        size: CGSize,
        lineColor: Color = Color(uiColor: .pr600),
        lineWidth: CGFloat = 2,
        verticalLineWidth: CGFloat = 1,
        onTap: ((Double, String?) -> Void)? = nil,
        onEnd: (() -> Void)? = nil
    ) {
        self.prices = prices
        self.timeline = timeline
        values = prices.map { $0.price }
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.verticalLineWidth = verticalLineWidth
        self.size = size
        self.showTimeLine = showTimeLine
        self.onEnd = onEnd
        self.onTap = onTap
    }

    public var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ZStack {
                    LineChartShape(data: values)
                        .stroke(lineColor, style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round,
                            lineJoin: .round
                        ))
                        .background(
                            LineChartShape(data: values, isBackground: true)
                                .fill(.linearGradient(
                                    colors: [
                                        themeProvider.currentTheme.colors.uiLineChartBackground,
                                        .clear,
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
                .overlay(alignment: .trailing) {
                    if !showVerticalLine {
                        pulseView(in: geometry.frame(in: .global))
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
            .padding(.trailing, 24)

            if showTimeLine {
                HStack {
                    ForEach(timeline, id: \.self) { time in
                        Text(time)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func pulseView(in rect: CGRect) -> some View {
        if !values.isEmpty {
            let index = values.count - 1

            let maxY = values.max() ?? 0
            let minY = values.min() ?? 0
            let yAxis: CGFloat = maxY - minY

            let xStep = rect.width / Double(index)

            let xCenter = Double(index) * xStep
            let yCenter = (1 - CGFloat((Double(values[index]) - minY) / yAxis)) * rect.height

            ZStack {
                AnimatedPlotPointView(
                    fillColor: lineColor,
                    size: .init(width: 36, height: 36)
                )
            }
            .position(x: xCenter, y: yCenter)
        }
    }

    private func updateIndicator(geometry: GeometryProxy, value: CGFloat) {
        let index = Int((value / geometry.size.width) * CGFloat(values.count - 1))
        indicatorValue = Double(index)
        tapLocation = CGPoint(x: CGFloat(index) * (geometry.size.width / CGFloat(values.count - 1)), y: 0)
        showVerticalLine = true

        let timelineItem = index < timeline.count ? timeline[index] : nil
        let value = index < values.count ? values[index] : 0
        onTap?(value, timelineItem)
    }

    private func verticalLine(in size: CGSize) -> some View {
        Path { path in
            path.move(to: .init(x: tapLocation.x, y: 0))
            path.addLine(to: .init(x: tapLocation.x, y: size.height))
        }
        .stroke(lineColor, style: StrokeStyle(
            lineWidth: verticalLineWidth,
            lineCap: .round,
            lineJoin: .round
        ))
    }

    private func lighterShape(in size: CGSize) -> some View {
        let suffixValues = Array(values.suffix(from: Int(indicatorValue)))

        return LighterShape(
            tapLocation: tapLocation.x,
            data: suffixValues,
            totalWidth: size.width,
            totalValues: values
        )
        .stroke(lineWidth: lineWidth)
        .fill(colorScheme == .light ? .white.opacity(0.4) : .black.opacity(0.4))
        .frame(height: size.height)
    }

    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                updateIndicator(geometry: geometry, value: value.location.x)
            }
            .onEnded { _ in
                onEnd?()
                showVerticalLine = false
            }
    }

    private var plotPointsView: some View {
        ZStack {
            PlotPoint(
                data: values,
                index: Int(indicatorValue),
                size: 24.0
            )
            .fill(lineColor.opacity(0.2))

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
        for _ in 1 ... 20 {
            let chartItem = ChartData(price: Double.random(in: 100 ... 200))
            chartItems.append(chartItem)
        }
        return chartItems
    }

    static func getTimeLine() -> [String] {
        return (2019 ... 2024).map { String($0) }
    }

    static var previews: some View {
        LineChartView(
            prices: getChartData(),
            timeline: [],
            showTimeLine: false,
            size: .init(width: 300, height: 300)
        )
        .previewable()
    }
}
