//
//  FirstViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/05/22.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//
import UIKit
import WebKit
class FirstViewController: UIViewController,WKUIDelegate,WKNavigationDelegate,UIPickerViewDelegate, UIPickerViewDataSource{
    

    @IBOutlet weak var uiPickerViewLearn: UIPickerView!
    @IBOutlet weak var uiPickerViewAge: UIPickerView!
    @IBOutlet var initView: UIView!
    @IBOutlet weak var coverView: UIView!
    var menuController: MenuController!
    var indicator: UIActivityIndicatorView!
    var isExpanded = false
    let CONST_KEY_AGE: String = "CONST_KEY_AGE"
    let CONST_KEY_LEARN: String = "CONST_KEY_LEARN"
    let textsAge = ["20代","30代","40代以上"]
    let textsLearn = ["投資","ビジネス(副業)","投資とビジネス(副業)"]
    var selectedAgeCode = 0 // 0:20代 1:30代 2:40代以上
    var selectedLearnCode = 0 //0:投資 1:ビジネス(副業) 2:投資とビジネス(副業)
    
    // MARK: - 初期表示
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートの設定
        uiPickerViewAge.delegate = self
        uiPickerViewAge.dataSource = self
        uiPickerViewLearn.delegate = self
        uiPickerViewLearn.dataSource = self
        cofigureNavigationBar()
        configureKurukuru()
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: CONST_KEY_AGE) {
            print(stringOne) // Some String Value
        }
        if let stringTwo = defaults.string(forKey: CONST_KEY_LEARN) {
            print(stringTwo) // Another String Value
        }
        animatedIn()
    }
    // MARK: - サブビュー：登録ボタン押下
    @IBAction func regist(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(selectedAgeCode, forKey: CONST_KEY_AGE)
        defaults.set(selectedLearnCode, forKey: CONST_KEY_LEARN)
        initView.removeFromSuperview()
        self.coverView.isHidden = true
    }

    // MARK: - サブビュー：キャンセルボタン押下
    @IBAction func cancel(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: CONST_KEY_AGE) //キャンセルの場合、年齢は30代に設定
        defaults.set("2", forKey: CONST_KEY_LEARN) //キャンセルの場合、学びたいことは投資とビジネスに設定
        initView.removeFromSuperview()
        self.coverView.isHidden = true
    }

    
    // MARK: - 関数
    func setView(){
        initView.layer.cornerRadius = 5
        initView.center = self.view.center
        initView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        initView.alpha = 1
        self.tabBarController?.view.addSubview(coverView)
        self.coverView.addSubview(initView)
    }
    
    func animatedIn(){
        initView.layer.cornerRadius = 5
        initView.center = self.view.center
        initView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        initView.alpha = 1
        self.tabBarController?.view.addSubview(coverView)
        self.coverView.addSubview(initView)
    }

    func cofigureNavigationBar(){
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
            self.menuController.view.frame.origin.y = -self.view.frame.height
        }
    }
    
    func animatePanel(shouldExpand: Bool,forMenuOption menuOption: MenuOption?){
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.3, delay: 0,
                           options: .curveEaseInOut,animations:{
                            self.menuController.view.frame.origin.y = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
                            self.view.bringSubviewToFront(self.menuController.view)
            } , completion: nil)
            
        } else {
            // hide menu
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                self.menuController.view.frame.origin.y = -self.view.frame.height
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }
    func didSelectMenuOption(menuOption: MenuOption) {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame:.zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        switch menuOption {
            
        case .about:
            let myURL = URL(string:"https://okaneno-gakko.jp/about")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        case .first_challenge:
            let myURL = URL(string:"https://okaneno-gakko.jp/first_challenge")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        case .company:
            let myURL = URL(string:"https://okaneno-gakko.jp/company")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        case .contact:
            let myURL = URL(string:"https://okaneno-gakko.jp/contact")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    }
    // 読込中のくるくる回るアニメーション
    func configureKurukuru(){
        // UIActivityIndicatorViewを生成
        indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
    }

    // MARK: - picker設定
    // pickerの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerに表示する値の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == uiPickerViewAge {
            return textsAge.count
        } else {
            return textsLearn.count
        }
    }
    
     //pickerに表示する値を返すデリゲートメソッド.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == uiPickerViewAge {
            return textsAge[row]
        } else {
            return textsLearn[row]
        }
    }
    
    // pickerが選択された際に呼ばれるデリゲートメソッド.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == uiPickerViewAge {
            selectedAgeCode = row
            print(textsAge[row])
        } else {
            selectedLearnCode = row
            print(textsLearn[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        // 表示するラベルを生成する
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        label.textAlignment = .center
        if pickerView == uiPickerViewAge {
            label.text = textsAge[row]
        } else {
            label.text = textsLearn[row]
        }
        label.font = UIFont(name: "System",size:5)
        return label
    }
    

}
