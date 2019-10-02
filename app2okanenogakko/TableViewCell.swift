//
//  TableViewCell.swift
//  app2okanenogakko
//
//  Created by 多田隆太郎 on 2019/09/30.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCells(title: String, detail: String,image :UIImage) {
        self.cellTitle.text = title
        self.cellDetail.text = detail
        self.cellImage.image = image
    }

}
