//
//  WebviewVC.swift
//  app2okanenogakko
//
//  Created by 多田隆太郎 on 2019/10/02.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    public var myURLString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        displayURL()
    }
    func displayURL() {
        let myURL = NSURL(string: self.myURLString)
        let myURLRequest = NSURLRequest(url:myURL! as URL)
        webview.load(myURLRequest as URLRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
