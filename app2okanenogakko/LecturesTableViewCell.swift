//
//  LecturesTableViewCell.swift
//  
//
//  Created by 多田隆太郎 on 2019/09/29.
//

import UIKit

class LecturesTableViewCell: UITableViewCell {

    @IBOutlet var images: UIImageView!
    @IBOutlet var titles: UILabel!
    @IBOutlet var details: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setLecturesTable(index: IndexPath){
      self.titles.text = String(index.row)
      self.details.text = String(index.row)
      self.images.image = UIImage(named: "init.png")
    }
}
