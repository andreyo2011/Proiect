//
//  ArticleViewController.swift
//  Laborator3
//
//  Created by user216460 on 9/1/22.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        
        let urlPath = "https://stbsa.ro/comunicat"
        let url = URL(string: urlPath)
        let requestObj = URLRequest(url: url! as URL)
        webView.load(requestObj)
    }
}
