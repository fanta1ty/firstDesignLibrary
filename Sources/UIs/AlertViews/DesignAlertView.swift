//  Created by Thinh Nguyen
//

import SwiftUI

public struct DesignAlertView: View {
    @Binding var presentAlert: Bool
    @State var alertType: DesignAlertType = .success(
        "Title",
        "This is success message!"
    )

    var isShowVerticalButtons = false

    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?

    let verticalButtonHeight: CGFloat = 80

    public init(
        presentAlert: Binding<Bool>,
        alertType: DesignAlertType,
        isShowVerticalButtons: Bool,
        leftButtonAction: (() -> Void)?,
        rightButtonAction: (() -> Void)?
    ) {
        _presentAlert = presentAlert

        self.alertType = alertType
        self.isShowVerticalButtons = isShowVerticalButtons
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }

    public var body: some View {
        ZStack {
            Color.black
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0, content: {
                if !alertType.title().isEmpty {
                    Text(alertType.title())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)

                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)

                if !isShowVerticalButtons {
                    HStack(spacing: 0) {
                        if !alertType.leftActionText.isEmpty {
                            Button {
                                leftButtonAction?()
                            } label: {
                                Text(alertType.leftActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity,
                                           minHeight: 0, maxHeight: .infinity)
                            }
                            Divider()
                                .frame(minWidth: 0, maxWidth: 0.5,
                                       minHeight: 0, maxHeight: .infinity)
                        }

                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity,
                                       minHeight: 0, maxHeight: .infinity)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)
                } else {
                    VStack(spacing: 0) {
                        Spacer()
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity,
                                       minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()

                        Divider()

                        Spacer()

                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity,
                                       minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                    }
                    .frame(height: verticalButtonHeight)
                }
            })
            .frame(
                width: 270,
                height: alertType.height(
                    isShowVerticalButton: isShowVerticalButtons
                )
            )
            .background(.white)
            .cornerRadius(4)
        }
        .zIndex(2.0)
    }
}

struct DesignAlertView_Preview: PreviewProvider {
    static var previews: some View {
        DesignAlertView(
            presentAlert: .constant(true),
            alertType: .success("Title", "This is success message!"),
            isShowVerticalButtons: true,
            leftButtonAction: nil,
            rightButtonAction: nil
        )
    }
}
