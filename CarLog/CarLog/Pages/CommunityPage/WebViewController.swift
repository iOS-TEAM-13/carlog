//
//  WebViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/16/23.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        webView = WKWebView()
        webView.navigationDelegate = self
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

}
