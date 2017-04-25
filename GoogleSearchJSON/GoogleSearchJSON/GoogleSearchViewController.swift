//
//  FirstViewController.swift
//  GoogleSearchJSON
//
//  Created by englieh on 28/8/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

import UIKit

class GoogleSearchViewController: UIViewController,URLSessionDataDelegate {
    @IBOutlet var searchString:UITextField!;
    @IBOutlet var activityIndicatorView:UIActivityIndicatorView!;
    var buffer:NSMutableData!;
    var searchResults:SearchResults!;
    
    @IBAction func search() {
        // Replace with your key and cx
        let key:String = "AIzaSyC9Su1cljqBs-SUXN88JhUFF1KDYxvH2hc"
        let cx:String = "014035784821814041892:assrnaxt7fk"
        let url:URL = URL(string: "https://www.googleapis.com/customsearch/v1?key=\(key)&cx=\(cx)&q=\(searchString.text!)&alt=json")!
        self.buffer = NSMutableData();
        
        
        // Continue your implementation to send the search request 
        // to Google. Remember to do the callback methods!
    }
 
    func processResponse(_ data:NSMutableData) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

