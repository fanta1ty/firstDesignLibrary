//  Created by Thinh Nguyen
//

import SwiftUI
import UIKit

struct PresentationBackgroundView: UIViewRepresentable {
    let color: UIColor

    func makeUIView(context _: Context) -> some UIView {
        let view = UIView()

        DispatchQueue.main.async {
            view.superview?
                .superview?.backgroundColor = color
        }

        return view
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        uiView.superview?
            .superview?
            .backgroundColor = color
    }
}
