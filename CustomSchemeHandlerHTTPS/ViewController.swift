//
//  ViewController.swift
//  CustomSchemeHandlerHTTPS
//
//  Created by Fujia Di on 2022/12/16.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        // The local js file contains the code to fetch from the custom scheme handler
        let url = Bundle.main.url(forResource: "main", withExtension: "js")!
        let js = try! String(contentsOf: url, encoding: .utf8)
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        config.setURLSchemeHandler(SchemeHandler(), forURLScheme: "custom-scheme")
        return WKWebView(frame: .zero, configuration: config)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        let url = URL(string: "https://example.com/")!
        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}


class SchemeHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        let url = urlSchemeTask.request.url!
        let asset = NSDataAsset(name: "dog")!
        urlSchemeTask.didReceive(URLResponse(url: url, mimeType: asset.typeIdentifier, expectedContentLength: asset.data.count, textEncodingName: nil))
        urlSchemeTask.didReceive(asset.data)
        urlSchemeTask.didFinish()
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {

    }
}

