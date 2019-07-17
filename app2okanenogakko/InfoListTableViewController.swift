//
//  InfoListTableViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/07/04.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit
import Firebase

class InfoListTableViewController: UITableViewController {

    // お知らせリスト
    var infoList = [[String:String]]()
    // お知らせリスト
    var info = [String:String]()
    // インスタンス変数
    var DBRef:DatabaseReference!

    //最初からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        loadInfomation()
    }

    func loadInfomation() {
        //データベース参照
        let ref = Database.database().reference(fromURL: "https://okaneno-gakko-40016.firebaseio.com/")
        //データを取得
        ref.child("info").observe(.value) { (snap) in
            // お知らせを初期化（前回から値が更新されたときに呼び出されるため、既存のお知らせを消す）
            self.infoList = [[String:String]]()
            for data in snap.children {
                let snapdata = data as! DataSnapshot
                //１つのデータ
                let item = snapdata.value as! [String:String]
                self.infoList.append(item)
            }
            // 最新のお知らせが上位に表示されるように順序をが逆に並び替える
            var count: Int = 0
            let arrayMaxIndex: Int = self.infoList.count-1
            var reverseInfoList = [[String:String]]()
            for _ in self.infoList {
                reverseInfoList.append(self.infoList[arrayMaxIndex - count])
                count += 1
                if (30 <= count) {
                    // 30件以上のお知らせは表示しない
                    break;
                }
            }
            self.infoList = reverseInfoList
            //tableViewを更新
            self.tableView.reloadData()
        }
    }
    
    //最初からあるコード
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //セルの個数を指定するデリゲートメソッド（必須）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    //セルに値を設定するデータソースメソッド（必須）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // DBを手動編集するためキーに「title」が設定されていなかった場合、何も表示しない
        if infoList[indexPath.row]["title"] == nil {
            cell.textLabel!.text = ""
        } else{
            cell.textLabel!.text = infoList[indexPath.row]["title"]
        }
        return cell
    }
    
    // セルタップ時のアクション
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 遷移先に引き渡すパラメータを設定
        self.info = self.infoList[indexPath.row]
        // 別の画面に遷移
        self.performSegue(withIdentifier: "toInfoDetailViewController", sender: nil)
    }

    //遷移する際の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfoDetailViewController" {
            let infoDetailViewController = segue.destination as! InfoDetailViewController
            infoDetailViewController.info = self.info
        }
    }
    

}

