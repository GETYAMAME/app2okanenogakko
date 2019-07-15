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
    
    //追加③ セルの個数を指定するデリゲートメソッド（必須）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    //追加④ セルに値を設定するデータソースメソッド（必須）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = infoList[indexPath.row]["title"]
        return cell
    }

}
