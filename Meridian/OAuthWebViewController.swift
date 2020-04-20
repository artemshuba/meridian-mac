//
//  OAuthWebViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 02/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import WebKit

protocol OAuthWebViewControllerDelegate : class {
    func oauth(_ oAuthWebViewController: OAuthWebViewController, didReceive accessToken: String, userId: String)
}

class OAuthWebViewController : UIViewController {
    private lazy var webView = WKWebView()
    
    weak var delegate: OAuthWebViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupViews()
    }
    
    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    private func setupLayout() {
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupViews() {
        webView.navigationDelegate = self
    }
}

extension OAuthWebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(webView.url)
        
        guard let url = webView.url,
            url.absoluteString.starts(with: "https://oauth.vk.com/blank.html") else { return }
        
        var components = URLComponents()
        components.query = url.fragment

        let accessToken = (components.queryItems?.first(where: { $0.name == "access_token" })?.value)!
        let userId = (components.queryItems?.first(where: { $0.name == "user_id" })?.value)!
        
        delegate?.oauth(self, didReceive: accessToken, userId: userId)
        
        dismiss(animated: true, completion: nil)
    }
}
