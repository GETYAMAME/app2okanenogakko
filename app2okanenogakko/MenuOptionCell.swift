//
//  MenuOptionCell.swift
//  appokanenogakko
//
//  Created by mac user on 2019/05/20.
//  Copyright © 2019 mycompany. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    // MARK: - プロパティ
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    // MARK: - 初期表示
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .green
        selectionStyle = .none

        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ハンドラー

}
