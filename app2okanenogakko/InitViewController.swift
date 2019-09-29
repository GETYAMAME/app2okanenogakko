//
//  InitViewController.swift
//  app2okanenogakko
//
//  Created by 多田隆太郎 on 2019/09/27.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit
class InitViewController: UIViewController {

    @IBOutlet var initSettingView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!
    let data: String = "Hello"

    
    // MARK: - 初期表示
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting



        effect = visualEffectView.effect
        visualEffectView.effect = nil
        initSettingView.layer.cornerRadius = 5
        animatedIn()
    }
    
    func animatedIn(){
        initSettingView.center = self.view.center
        initSettingView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        initSettingView.alpha = 0
        self.view.addSubview(initSettingView)
        
        UIView.animate(withDuration: 0.4){
            self.visualEffectView.effect = self.effect
            self.initSettingView.alpha = 1
            
        }
    }

    @IBAction func regist(_ sender: Any) {
        visualEffectView.effect = nil
        initSettingView.removeFromSuperview()
        let defaults = UserDefaults.standard
        //self.performSegue(withIdentifier: "toTop", sender: nil)
    }
    // view表示時に毎度起動
    override func viewWillAppear(_ animated: Bool){
        //self.performSegue(withIdentifier: "toTop", sender: nil)
    }
    
}
