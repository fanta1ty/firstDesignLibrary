//  Created by Thinh Nguyen
//

import SwiftUI

public struct BottomSheetView<Content: View>: View {
  @ViewBuilder let content: () -> Content
  @EnvironmentObject var themeProvider: ThemeProvider
  @Environment(\.dismiss) var dismiss

  @State var overlayOpacity: CGFloat = 0
  @State var bottomOfset: CGFloat = 0
  @State var contentHeight: CGFloat = 300
  @Binding var dismissHolder: (() -> Void)?

  let showClose: Bool
  let showRoundCorner: Bool
  let closeStyle: LinearGradient?
  let backgroundColor: Color?

  public init(
    showClose: Bool = false,
    showRoundCorner: Bool = true,
    closeStyle: LinearGradient? = nil,
    backgroundColor: Color? = nil,
    dismissHolder: Binding<(() -> Void)?> = .constant(nil),
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
    self.showClose = showClose
    self.showRoundCorner = showRoundCorner
    self.closeStyle = closeStyle
    self.backgroundColor = backgroundColor
    _dismissHolder = dismissHolder
  }

  public var body: some View {
    ZStack {
      Color.black
        .opacity(overlayOpacity)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          customDismiss()
        }

      VStack(spacing: 0) {
        Spacer()
        ZStack {
          if showClose {
            HStack {
              Spacer()

              Button {
                customDismiss()
              } label: {
                Image(systemName: "xmark")
                  .font(.system(size: 20))
                  .frame(width: 24, height: 24)
                  .ifLet(closeStyle) { $1.foregroundStyle($0) }
                  .if(closeStyle == nil) {
                    $0.foregroundStyle(themeProvider.currentTheme.colors.iconActive)
                  }
                  .padding(.trailing, 24)
                  .padding(.top, 16)
              }
            }
          } else {
            themeProvider.currentTheme.colors.borderDisabled
              .frame(width: 50, height: 4)
              .cornerRadius(2)
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(backgroundColor ?? themeProvider.currentTheme.colors.uiBackgroundPrimary)
        .cornerRadius(showRoundCorner ? 16 : 0, corners: [.topLeft, .topRight])

        content()
          .background(themeProvider.currentTheme.colors.uiBackgroundPrimary)
          .background(
            GeometryReader(content: { geometry in
              Color.clear.onAppear {
                contentHeight = geometry.size.height
              }
            })
          )
      }
      .offset(CGSize(
        width: 0, height: bottomOfset
      ))
      .frame(maxWidth: .infinity)
    }
    .gesture(
      DragGesture()
        .onChanged({ gesture in
          let newBottom = max(0, gesture.translation.height)
          bottomOfset = newBottom
        })
        .onEnded({ gesture in
          let velocity = gesture.predictedEndLocation.y - gesture.location.y
          let translationWithVelocity = gesture.translation.height + velocity
          let velocityProgress = translationWithVelocity / contentHeight
          let shouldComplete = velocityProgress > 0.5

          if shouldComplete {
            customDismiss()
          } else {
            withAnimation {
              bottomOfset = 0
            }
          }
        })
    )
    .onAppear {
      guard overlayOpacity == 0 else { return }

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
        withAnimation {
          overlayOpacity = 0.3
        }
      })
      dismissHolder = customDismiss
    }
    .onDisappear {
      dismissHolder = nil
    }
    .presentationBackground(color: .clear)
  }

  private func customDismiss() {
    withAnimation(.easeIn(duration: 0.3)) {
      bottomOfset = contentHeight
    }

    withAnimation(.linear(duration: 0.3)) {
      overlayOpacity = 0
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
      withoutAnimation(dismiss.callAsFunction)
    })
  }
}

struct BottomSheetView_Preview: PreviewProvider {
  struct Preview: View {
    @State var isPresented: Bool = false

    var body: some View {
      Button("Present") {
        isPresented.toggle()
      }
      .fullScreenCover(isPresented: $isPresented, content: {
        BottomSheetView {
          VStack(spacing: 16) {
            Text("Text 1")
            Text("Text 2")
            Button("Dismiss") {
              isPresented.toggle()
            }
          }
          .padding()
          .frame(maxWidth: .infinity)
        }
      })
    }
  }

  static var previews: some View {
    Preview()
      .previewable()
  }
}
