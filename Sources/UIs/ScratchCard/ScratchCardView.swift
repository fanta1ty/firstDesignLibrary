//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - ScratchCardView

public struct ScratchCardView<Content: View, OverlayView: View>: View {
    @State var startingPoint: CGPoint = .zero
    @State var points: [CGPoint] = []
    @GestureState var gestureLocation: CGPoint = .zero
    @Binding var onFinish: Bool
    @Binding var onStart: Bool

    var content: Content
    var overlayView: OverlayView
    var cursorSize: CGFloat

    let size: (CGFloat, CGFloat)

    public init(
        cursorSize: CGFloat,
        size: (CGFloat, CGFloat),
        onStart: Binding<Bool>,
        onFinish: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlayView: @escaping () -> OverlayView
    ) {
        self.content = content()
        self.overlayView = overlayView()
        self.cursorSize = cursorSize
        self.size = size
        _onFinish = onFinish
        _onStart = onStart
    }

    public var body: some View {
        ZStack {
            overlayView
                .opacity(onFinish ? 0 : 1)

            content
                .mask(ZStack {
                    if !onFinish {
                        ScratchMask(points: points, startingPoint: startingPoint)
                            .stroke(style: StrokeStyle(
                                lineWidth: cursorSize,
                                lineCap: .round,
                                lineJoin: .round
                            ))
                    } else {
                        Rectangle()
                    }
                })
                .animation(.easeInOut, value: onFinish)
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                            if !onStart {
                                onStart = true
                            }
                        }
                        .updating($gestureLocation, body: { value, out, _ in
                            out = value.location

                            DispatchQueue.main.async {
                                if startingPoint == .zero {
                                    startingPoint = value.location
                                }
                                points.append(value.location)
                            }
                        })
                        .onEnded { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation(.easeInOut) {
                                    onFinish = true
                                }
                            }
                        }
                )
        }
        .frame(width: size.0, height: size.1)
        .cornerRadius(8)
        .onChange(of: onFinish, perform: { _ in
            if !onFinish, !points.isEmpty {
                withAnimation(.easeInOut) {
                    resetView()
                }
            }
        })
    }

    func resetView() {
        points.removeAll()
        startingPoint = .zero
    }
}

// MARK: - ScratchCardView_Preview

struct ScratchCardView_Preview: PreviewProvider {
    static var previews: some View {
        ScratchCardView(
            cursorSize: 25,
            size: (320, 320),
            onStart: .constant(true),
            onFinish: .constant(false),
            content: {
                ZStack(alignment: .center) {
                    Image(uiImage: .strokedCheckmark)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }, overlayView: {
                Image(uiImage: .add)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        )
        .previewable()
    }
}
