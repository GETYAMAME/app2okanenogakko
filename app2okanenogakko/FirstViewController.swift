//
//  FirstViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/05/22.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//
import UIKit
import WebKit
import Firebase

class FirstViewController:AbstractViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mylectureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        // UIImage インスタンスの生成
        let url = URL(string: mylectureList[indexPath.row]["imageUrl"]!)
        do {
            let data = try Data(contentsOf: url!)
            let urlImage = UIImage(data: data)!
              cell.setCells(title: mylectureList[indexPath.row]["title"]!, detail: mylectureList[indexPath.row]["detail"]! ,image: urlImage)
         }catch let err {
              print("Error : \(err.localizedDescription)")
        }
        return cell
    }
    // セルタップ時のアクション
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 遷移先に引き渡すパラメータを設定
        self.selectedUrl = self.mylectureList[indexPath.row]["linkUrl"]!
        // 別の画面に遷移
        self.performSegue(withIdentifier: "toWebViewController", sender: nil)
    }
    //遷移する際の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebViewController" {
            let WebViewController = segue.destination as! WebViewController
            WebViewController.myURLString = selectedUrl
        }
    }
    //
    override func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        // 遷移先に引き渡すパラメータを設定
        case .about:
            self.selectedUrl = "https://okaneno-gakko.jp/about"
        case .first_challenge:
            self.selectedUrl = "https://okaneno-gakko.jp/first_challenge"
        case .company:
            self.selectedUrl = "https://okaneno-gakko.jp/company"
        case .contact:
            self.selectedUrl = "https://okaneno-gakko.jp/contact"
        }
        // 別の画面に遷移
        self.performSegue(withIdentifier: "toWebViewController", sender: nil)
    }

    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tableView.frame.height)
        loadInfomation()
    }

    func loadInfomation() {
        //データベース参照
        let ref = Database.database().reference(fromURL: "https://okaneno-gakko-40016.firebaseio.com/")
        ref.child("sort").observe(.value) { (snap) in
            // 初期化
            self.sortList = [String]()
            // ソート順を取得
            for data in snap.children {
                let snapdata = data as! DataSnapshot
                //１つのデータ
                let item = snapdata.value as! String
                self.sortList.append(item)
            }
        }
        ref.child("lecture").observe(.value) { (snap) in
            //初期化
            self.lectureList = [[String:String]]()
            // 講座一覧を取得
            for data in snap.children {
                let snapdata = data as! DataSnapshot
                //１つのデータ
                let item = snapdata.value as! [String:String]
                self.lectureList.append(item)
            }
            let defaults = UserDefaults.standard
            // 初期表示ではない かつ データ取得を行なっている場合にデータの並びかえを行う
            if defaults.string(forKey: self.CONST_KEY_SORT) != nil && self.lectureList.isEmpty == false {
                self.sortData()
            }
        }
    }
    // 画面表示する項目を並べ替える
    func sortData(){
        mylectureList = [[String:String]]()
        let defaults = UserDefaults.standard
        let sortCode = defaults.string(forKey: self.CONST_KEY_SORT)
        let mySort = self.sortList[Int(sortCode!)!]
        let mySortList = mySort.components(separatedBy: ",")
        for sortnum in mySortList {
           mylectureList.append((lectureList[Int(sortnum)! - 1]))
        }
        //tableViewを更新
        self.tableView.reloadData()
    }
    
    // お知らせリスト
    var selectedUrl: String = ""
    var sortList = [String]()
    var lectureList = [[String:String]]()
    var mylectureList = [[String:String]]()
    @IBOutlet weak var uiPickerViewLearn: UIPickerView!
    @IBOutlet weak var uiPickerViewAge: UIPickerView!
    @IBOutlet var initView: UIView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let CONST_KEY_SORT: String = "CONST_KEY_SORT"
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
        // iPhoneの各機種に対応できるように調整
        self.coverView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tableView.frame.height)
        if let stringOne = defaults.string(forKey: CONST_KEY_SORT) {
            initView.removeFromSuperview()
            self.coverView.isHidden = true
            print(stringOne) // Some String Value
        } else {
            animatedIn()
        }
    }
    // MARK: - サブビュー：登録ボタン押下
    @IBAction func regist(_ sender: Any) {
        let defaults = UserDefaults.standard
        let selectSortCode = (selectedAgeCode * 3) + selectedLearnCode
        defaults.set(selectSortCode, forKey: CONST_KEY_SORT)
        initView.removeFromSuperview()
        self.coverView.isHidden = true
        self.sortData()
    }

    // MARK: - サブビュー：キャンセルボタン押下
    @IBAction func cancel(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("5", forKey: CONST_KEY_SORT) //キャンセルの場合、30代で学びたいことは投資とビジネスに設定
        initView.removeFromSuperview()
        self.coverView.isHidden = true
        self.sortData()
    }
    
    func animatedIn(){
        initView.layer.cornerRadius = 5
        initView.center = self.view.center
        initView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        initView.alpha = 1
        self.tabBarController?.view.addSubview(coverView)
        self.coverView.addSubview(initView)
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
