//
//  FirstViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/05/22.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

class FirstViewController: AbstractViewController {

    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        // 講座一覧を初期ページに設定
        pageSetWebView(path: "lp-app")
        super.viewWillAppear(animated)
    }

}
