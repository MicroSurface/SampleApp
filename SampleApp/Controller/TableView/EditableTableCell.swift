//
//  EditableTableCell.swift
//  SampleApp
//
//  Created by Frank on 2020/4/2.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class EditableTableCell: UITableViewCell {
    lazy var titleLb: UILabel = UILabel()
    lazy var concernCircle: UIView = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        concernCircle.backgroundColor = .red
        concernCircle.layer.cornerRadius = 10
        concernCircle.isHidden = true
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(concernCircle)
        titleLb.snp.makeConstraints({ (make) in
            make.topMargin.equalToSuperview().offset(10)
            make.bottomMargin.equalToSuperview().offset(-10)
            make.leftMargin.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        concernCircle.snp.makeConstraints({ (make) in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.rightMargin.equalToSuperview().offset(-20)
        })
    }
    
    func setItem(item: EditableDataList) {
        titleLb.text = item.title
        if !item.isSelected {
            concernCircle.isHidden = true
            return
        }
        if item.isConcerned {
            concernCircle.isHidden = false
        } else {
            concernCircle.isHidden = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
