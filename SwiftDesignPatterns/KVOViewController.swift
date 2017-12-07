//
//  KVOViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 06/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//


//The observed item here is the web view and i want to check its progress

import UIKit
import WebKit

class KVOViewController: UIViewController {
    
    var webView: WKWebView!
    let keyPathToObserve:String = "estimatedProgress"
    let url = "http://andreitudorionescu.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "KVO"
        self.webView = WKWebView()
        self.view = webView
        self.webView.addObserver(self, forKeyPath: keyPathToObserve, options: .new, context: nil)
        loadPage()
    }
    
    func loadPage() {
        guard let unwrappedURL = URL(string: url) else { return }
        let urlRequest = URLRequest(url: unwrappedURL)
        self.webView.load(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPathToObserve {
            print("Website Loaded \(self.webView.estimatedProgress*100)%")
        }
    }
    
    //Eliminate the observer when the web view is fully loaded
    deinit {
        self.webView.removeObserver(self, forKeyPath: keyPathToObserve, context: nil)
    }

}
