//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class HighlightControl: UIControl {
    @IBInspectable public var highlightColor: UIColor?
    @IBInspectable public var normalColor: UIColor?

    public var highlightAlpha: CGFloat?

    override public var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightColor : normalColor
            alpha = isHighlighted ? highlightAlpha ?? 1 : 1
        }
    }

    public func disableAllSubviewsInteractions() {
        subviews.forEach { $0.isUserInteractionEnabled = false }
    }
}
