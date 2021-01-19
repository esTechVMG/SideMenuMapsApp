//
//  WebViewScreenController.swift
//  SideMenuMapsApp
//
//  Created by esTechVMG on 18/1/21.
//

import UIKit
import WebKit
class WebViewScreenController : UIViewController, WKNavigationDelegate, WKUIDelegate {
    //IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var addressBar: UITextField!
    
    override func viewDidLoad() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        //Load School Web
        var test:Int = 34;
        print("Hello World")
        loadURLwithString(str: "https://escuelaestech.es/")
    }
    func btnUpdate() -> Void {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    func loadURLwithString(str:String) -> Void {
        guard let url = URL(string: str) else {
            let alert = UIAlertController(title: "Error", message: "URL Invalida", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
            return
            
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    //WebView Buttons
    
    
    @IBAction func reloadBtnPressed(_ sender: Any) {
        if webView.isLoading{
            /*
             WKWebview as far as searched doesn t have a method
             for listening when webview stops loading by calling webView.stopLoading()
             therefore, it is updated manually from this func.
             */
            reloadButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            webView.stopLoading()
        }else{
            webView.reload()
        }
    }
    @IBAction func forwardBtnPressed(_ sender: Any) {
        webView.goForward()
        btnUpdate()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        webView.goBack()
        btnUpdate()
    }
    
    //WKWebview
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        btnUpdate()
        //print("I finished loading")
        reloadButton.setImage(UIImage(systemName: "repeat"), for: .normal) //Update reload button icon
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Im being loaded")
        reloadButton.setImage(UIImage(systemName: "xmark"), for: .normal) //Update reload button icon
    }
    @IBAction func enterBtnPressed(_ sender: Any) {
        if let address = addressBar.text {
            if !address.isEmpty{
                loadURLwithString(str: address)
            }
        }
    }
}
