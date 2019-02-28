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
    
    @IBOutlet weak var bannerView           : GADBannerView!
    @IBOutlet weak var myWebView            : WKWebView!
    @IBOutlet weak var myActivityIndicator  : UIActivityIndicatorView!
    var linkFromVC                          : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerInit()
        myWebView.navigationDelegate = self
        
        if let okLink = linkFromVC, let okUrl = URL(string: okLink) {
            let request = URLRequest(url: okUrl)
            myWebView.load(request)
        }
    }
    
    private func bannerInit() {
        bannerView.adUnitID = "ca-app-pub-2373410982348314/3824171467" // AD ID
        //        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // AD test ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
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
    }
}

extension WebViewViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("success")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("fail")
    }
}
