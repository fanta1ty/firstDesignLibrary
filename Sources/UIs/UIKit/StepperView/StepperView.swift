//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class StepperView: UIStackView {
    var currentProgress: Int = 0
    public var lineBackgroundColor: UIColor = .uiBackgroundTertiary

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}
