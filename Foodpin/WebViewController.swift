//
//  WebViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 12/13/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: "http://www.appcoda.com/contact") {
            let urlRequest = NSURLRequest(URL: url)
            webView.loadRequest(urlRequest)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
