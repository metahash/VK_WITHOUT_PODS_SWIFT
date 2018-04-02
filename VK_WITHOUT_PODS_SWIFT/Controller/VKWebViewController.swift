//
//  VKWebViewController.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit
import WebKit

class VKWebViewController: UIViewController, UIWebViewDelegate {
    
    let urlString = """
 https://oauth.vk.com/authorize?\
 client_id=6424085&\
 scope=401430&\
 redirect_uri=https://oauth.vk.com/blank.html&\
 display=mobile&\
 v=5.21&\
 response_type=token
 """
    var access_token = ""
    var user_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Auth"
    }
    
    func vkWebView() {
        var rect: CGRect = view.bounds
        rect.origin = CGPoint.zero
        let webView = UIWebView(frame: rect)
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        webView.tag = 100
        view.addSubview(webView)
        
        let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(VKWebViewController.removeSubview))
        
        navigationItem.setRightBarButton(item, animated: true)
        navigationItem.title = "Log In"
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        webView.delegate = self
        webView.loadRequest(request)
        
    }
    
    @IBAction func buttonDidTapped(_ sender: Any) {
        vkWebView()
    }
    
    @objc func removeSubview(){
        print("Cancel")
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            navigationItem.title = "Auth"
        }
        else{
            print("No Cancel!")
        }
    }
}

extension VKWebViewController {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let data = "\(request)"
        
        if data.range(of: "#access_token=") != nil {
            
            self.access_token = (String(describing: (String(describing: data.split(separator: "=" )[1])).split(separator: "&" )[0]))
            
            self.user_id = String(describing: data.split(separator: "=" )[3])
            
            print("\n\naccess_token == \(access_token)\n\n")
            print("user_id == \(user_id)\n\n")
            
            performSegue(withIdentifier: "friends", sender: nil)
        }
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)");
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview started Loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview did finish load")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friends" {
            
            let navVC = segue.destination as! UINavigationController
            let destinationVC = navVC.topViewController as! FriendsViewController
            destinationVC.user_id = user_id;
        }
    }

    
}

