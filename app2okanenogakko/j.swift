//
//  MyNavigationController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/05/22.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
        // Do any additional setup after loading the view.
    }
    

    func cofigureNavigationBar(){
        // ナビゲーションバー全体の設定
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        // ロゴ設定
        let imageView = UIImageView(image:UIImage(named:"logo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        // 戻るボタン設定
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = .lightGray
        self.navigationItem.leftBarButtonItem = backButtonItem
        // メニュー設定
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Image") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    // メニューボタン制御
    @objc func handleMenuToggle(){
        print("tap")
    }

}
