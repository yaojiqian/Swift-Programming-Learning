//
//  ViewController.swift
//  Loading Web Pages with WebKit
//
//  Created by Yao Jiqian on 26/05/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        webView = WKWebView(frame: view.bounds, configuration : configuration)
        
        if let theWebView = webView {
            let url = URL(string :"https://www.apple.com")
            let urlRequest = URLRequest(url: url!)
            
            theWebView.load(urlRequest)
            theWebView.navigationDelegate = self
            
            view.addSubview(theWebView)
        }
    }

    /* Start the network activity indicator when the web view is loading */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    /* Stop the network activity indicator when the loading finishes */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

