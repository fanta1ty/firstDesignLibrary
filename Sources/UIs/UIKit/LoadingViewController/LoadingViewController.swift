//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class LoadingViewController: UIViewController {
    @Published public var isAppearing: Bool = false
    public var hasViewAppeared: Bool = false
    public var cancellables: [AnyCancellable] = []

    public let loading = DotsLoadingView(colors: nil)

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        loading.isUserInteractionEnabled = false
        loading.contentMode = .scaleAspectFill

        ContextManager.shared.startupManager.$error.sink { [weak self] error in
            guard let self else { return }

            if let error = error {
                print("Loading error: \(error)")
            }
        }.store(in: &cancellables)

        Publishers.CombineLatest($isAppearing.removeDuplicates(), ContextManager.shared.startupManager.$error)
            .sink { [weak self] isAppearing, error in
                guard isAppearing, let error = error else { return }
                self?.presentError(error)
            }
            .store(in: &cancellables)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isAppearing = true

        if !hasViewAppeared {
            ContextManager.shared.startupManager.$isReady.filter { $0 }.first()
                .sink { [weak loading] isReady in
                    guard isReady else { return }

                    // loading?.stop()
                }
                .store(in: &cancellables)
        }

        hasViewAppeared = true
    }

    private func presentError(_: Error) {}
}
