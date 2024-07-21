//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public struct SnackbarView: View {
  @EnvironmentObject var themeProvider: ThemeProvider
  @Binding var isShow: Bool
  @State var opacity: CGFloat = 1

  let message: String
  let animateDuration: TimeInterval = 2

  public init(
    message: String,
    isShow: Binding<Bool>
  ) {
    self.message = message
    _isShow = isShow
  }

  public var body: some View {
    HStack(spacing: 4) {
      Image(uiImage: .strokedCheckmark)
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(themeProvider.currentTheme.colors.iconDark)
        .padding(.leading, 8)

      Text(message)
        .font(themeProvider.currentTheme.fonts.body3)
        .foregroundColor(themeProvider.currentTheme.colors.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.vertical, .trailing], 10)
    }
    .background(themeProvider.currentTheme.colors.uiBackgroundViolet)
    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 12)
    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 0)
    .cornerRadius(4)
    .opacity(opacity)
    .empty(if: !isShow)
    .padding([.bottom, .horizontal], 16)
    .onChange(of: isShow) { newValue in
      if newValue {
        opacity = 1

        withAnimation(.easeInOut(duration: animateDuration).delay(0.5)) {
          opacity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration, execute: {
          isShow = false
        })
      }
    }
  }
}

struct SnackbarView_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      SnackbarView(
        message: "Test Snackbar",
        isShow: .constant(true)
      )
    }
    .previewable()
  }
}
