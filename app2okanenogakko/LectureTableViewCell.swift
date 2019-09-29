//
//  LectureTableViewCell.swift
//  app2okanenogakko
//
//  Created by 多田隆太郎 on 2019/09/29.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit

class LectureTableViewCell: UITableViewCell {



    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
    }
}
