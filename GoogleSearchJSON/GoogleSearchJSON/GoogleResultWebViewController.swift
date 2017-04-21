//
//  SecondViewController.swift
//  GoogleSearchJSON
//
//  Created by englieh on 28/8/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

import UIKit

class GoogleResultWebViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet var webView:UIWebView!;
    var searchResults:SearchResults!;
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self;
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let urlAddress:String = searchResults.selectedLink;
        
        //Create a URL object.
        let url:URL = URL(string: urlAddress)!;
        
        //URL Requst Object
        let requestObj:URLRequest = URLRequest(url: url);
        
        //Load the request in the UIWebView.
        webView.loadRequest(requestObj)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

