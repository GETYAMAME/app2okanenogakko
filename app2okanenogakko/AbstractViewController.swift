//
//  FirstViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/05/22.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//
import UIKit
import WebKit
class AbstractViewController: UIViewController, WKUIDelegate,WKNavigationDelegate  {
    
    // MARK: - プロパティ
    
    var menuController: MenuController!
    var isExpanded = false
    var delegate: AbstractViewController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    // MARK: - 初期表示
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
    }
    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        
    }
    
    // リンク先の画面設定
    func pageSetWebView(path :String){
        // 閲覧履歴初期化
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame:.zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        // スワイプ設定（戻る・進む）
        webView.allowsBackForwardNavigationGestures = true
        // 初期表示用のページ設定
        let myURL = URL(string:"https://okaneno-gakko.jp/" + path)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        menuController = nil
        isExpanded = false
    }
    
    // webview操作時のアクション
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let pageCount = webView.backForwardList.backList.count
        print(pageCount)
        if (0 < pageCount) {
            let back = UIBarButtonItem(title: "戻る",style: .plain,target: webView,action: #selector(webView.goBack))
            self.navigationItem.leftBarButtonItem = back
            return
        } else {
            let back = UIBarButtonItem(title: "戻る",style: .plain,target: webView,action: nil)
            back.tintColor = .lightGray
            self.navigationItem.leftBarButtonItem = back
        }
    }
    
    // MARK: - ハンドラー
    
    func cofigureNavigationBar(){
        // ナビゲーションバー全体の設定
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        // ロゴ設定
        let imageView = UIImageView(image:UIImage(named:"logo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        // 戻るボタン設定
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = .lightGray
        navigationItem.leftBarButtonItem = backButtonItem
        // メニュー設定
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Image") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    // メニューボタン制御
    @objc func handleMenuToggle(){
        handleMenuToggleImple(forMenuOption: nil)
    }
    // メニューボタン制御の実装部分（MenuControllerから呼び出されるケースを想定）
    func handleMenuToggleImple(forMenuOption menuOption: MenuOption?){
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, forMenuOption: menuOption)
    }
    
    // メニュー部分の初期設定
    func configureMenuController() {
        if menuController == nil {
            // add our menu controller here
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view,at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            // menuControlleのviewを親viewの右横に配置する
            self.menuController.view.frame.origin.x = self.view.frame.width
            self.menuController.view.frame.origin.y = 0
        }
    }
    
    func animatePanel(shouldExpand: Bool,forMenuOption menuOption: MenuOption?){
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.3, delay: 0,
                           options: .curveEaseInOut,animations:{
                            self.menuController.view.frame.origin.x = self.view.frame.width - 200
                            self.view.bringSubviewToFront(self.menuController.view)
            } , completion: nil)
            
        } else {
            // hide menu
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                //self.view.frame.origin.x = 0
                self.menuController.view.frame.origin.x = self.view.frame.width
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
            
        case .about:
            pageSetWebView(path: "about")
        case .first_challenge:
            pageSetWebView(path: "first_challenge")
        case .company:
            pageSetWebView(path: "company")
        case .contact:
            pageSetWebView(path: "contact")
        }
    }
    
}
