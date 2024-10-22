//  Created by Thinh Nguyen
//

import Foundation
import UIKit
import WebKit

public final class WebViewController: UIViewController {
    public let webView: WKWebView = .init()
    public let indicator = UIActivityIndicatorView(style: .medium)

    public var url: URL?
    public var dataInfo: DataInfo?

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .uiBackgroundPrimary

        navigationItem.leftBarButtonItem = .init(
            barButtonSystemItem: .stop, target: self, action: #selector(didSelectClose)
        )
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .action, target: self, action: #selector(didSelectShare)
        )

        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.anchorToFillSuperview(isTopSafe: true)

        if let url {
            indicator.hidesWhenStopped = true
            indicator.color = .textBody
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true

            webView.load(.init(url: url))
            indicator.startAnimating()
        } else if let dataInfo {
            webView.load(
                dataInfo.data,
                mimeType: dataInfo.mimeType,
                characterEncodingName: "UTF-8",
                baseURL: .init(fileURLWithPath: "")
            )
        }
    }

    @objc public func didSelectClose(_: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @objc public func didSelectShare(_: UIBarButtonItem) {
        if let url {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.share(data: data)
                }
            }
        } else if let data = dataInfo?.data {
            share(data: data)
        }
    }

    private func share(data: Data) {
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_: WKWebView, didFinish _: WKNavigation!) {
        indicator.stopAnimating()
    }

    public func webView(_: WKWebView, didFail _: WKNavigation!, withError _: any Error) {
        indicator.stopAnimating()
    }
}

extension WebViewController {
    static func instantiate(
        url: URL,
        title: String? = nil
    ) -> WebViewController {
        let vc = WebViewController()
        vc.url = url
        vc.title = title
        return vc
    }

    static func instantiate(
        data: Data,
        mimeType: String,
        title: String? = nil
    ) -> WebViewController {
        let vc = WebViewController()
        vc.dataInfo = DataInfo(data: data, mimeType: mimeType)
        vc.title = title
        return vc
    }
}

public extension WebViewController {
    struct DataInfo {
        public let data: Data
        public let mimeType: String
    }
}
