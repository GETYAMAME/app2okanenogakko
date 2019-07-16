//
//  InfoDetailViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/07/16.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit
import WebKit
class InfoDetailViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var title2: UITextView!
    @IBOutlet weak var message2: UITextView!
    var info = [String:String]()
    
    // MARK: - 初期表示
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        // 表示させるテキスト
        title2.text = info["title"]
        message2.text = info["message"]
        print(info)
        // labelをUIViewのサブビューに追加
        self.view.addSubview(title2)
        self.view.addSubview(message2)
    }
    
}
