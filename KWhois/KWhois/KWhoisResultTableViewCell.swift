//
//  KWhoisResultTableViewCell.swift
//  KWhois
//
//  Created by kiu on 2020/7/21.
//  Copyright © 2020 kiu. All rights reserved.
//

import Foundation
import UIKit

class KWhoisResultTableViewCell: UITableViewCell {

    var resultLabel : UILabel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white

        initCellUI()
    }

    func initCellUI() {

        resultLabel = UILabel.init(frame: CGRect.zero)
        resultLabel?.numberOfLines = 0
        resultLabel?.font      = UIFont.systemFont(ofSize: 14)
        resultLabel?.textColor = .black
        contentView.addSubview(resultLabel!)
        
        resultLabel?.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-15)
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
