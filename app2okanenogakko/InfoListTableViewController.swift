//
//  InfoListTableViewController.swift
//  app2okanenogakko
//
//  Created by mac user on 2019/07/04.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit

class InfoListTableViewController: UITableViewController {

    let TODO = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"] //追加②
    
    //最初からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //最初からあるコード
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //追加③ セルの個数を指定するデリゲートメソッド（必須）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    //追加④ セルに値を設定するデータソースメソッド（必須）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = TODO[indexPath.row]
        return cell
    }

}
