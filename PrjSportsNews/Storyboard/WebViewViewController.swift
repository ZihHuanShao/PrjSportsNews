//
//  WebViewViewController.swift
//  PrjSportsNews_v3
//
//  Created by Fred Shao on 2019/2/16.
//  Copyright © 2019年 FredShao. All rights reserved.
//

import UIKit
import WebKit
import GoogleMobileAds

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var myWebView            : WKWebView!
    @IBOutlet weak var myActivityIndicator  : UIActivityIndicatorView!
    var linkFromVC                          : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        if let okLink = linkFromVC, let okUrl = URL(string: okLink) {
            let request = URLRequest(url: okUrl)
            myWebView.load(request)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myWebView.uiDelegate = nil
        myWebView            = nil
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
}
