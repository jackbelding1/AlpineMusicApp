//
//  PrivacyWebViewViewController.swift
//  Alpine Music App
//
//  Created by Jack Belding on 5/2/23.
//

import UIKit
import WebKit

class PrivacyWebViewViewController: UIViewController {
    // the webview to be displayed
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    // the url to open in the webview
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
