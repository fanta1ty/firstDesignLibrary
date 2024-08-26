//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension StepperView {
    func set(progress value: Int, outOf total: Int) {
        if total != arrangedSubviews.count {
            set(arrangedSubviews: (0 ..< total).map { _ in
                let line = ProgressView()
                line.backgroundColor = lineBackgroundColor
                line.clipsToBounds = true
                line.layer.cornerRadius = 2

                return line
            })
            currentProgress = 0
        }

        let isReverse = value < currentProgress

        setRecursively(
            progress : value,
            index: isReverse ? total - 1: 0,
            isReverse: isReverse
        )

        currentProgress = value
    }

    func clear() {
        set(arrangedSubviews: [])
        currentProgress = 0
    }
}

extension StepperView {
    func setup() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 4
        isUserInteractionEnabled = false
        heightAnchor.constraint(equalToConstant: 4).isActive = true
    }

    func setRecursively(
        progress: Int,
        index: Int,
        isReverse: Bool,
        completion: (() -> Void)? = nil
    ) {
        guard index >= 0,
              index < arrangedSubviews.count,
              let line = arrangedSubviews[index] as? ProgressView
        else {
            return
        }

        let value: CGFloat = index < progress ? 1 : 0
        let animated = line.value != value
        let offset = isReverse ? -1 : 1

        line.set(value: value, animated: animated, completion: {
            self.setRecursively(
                progress: progress,
                index: index + offset,
                isReverse: isReverse,
                completion: completion
            )
        })
    }
}
