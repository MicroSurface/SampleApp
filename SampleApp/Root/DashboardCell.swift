//
//  DashboardCell.swift
//  SampleApp
//
//  Created by Frank on 2020/3/30.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class DashboardCell: UITableViewCell {
    lazy var cellView: UIView = UIView()
    lazy var titleLb: UILabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1.0)
        titleLb.font = UIFont.systemFont(ofSize: 18)
        titleLb.textColor = .white
        titleLb.textAlignment = .center
        self.contentView.addSubview(cellView)
        cellView.addSubview(titleLb)
        cellView.snp.makeConstraints({ (make) in
            make.topMargin.equalToSuperview().offset(5)
            make.leftMargin.equalToSuperview().offset(20)
            make.rightMargin.equalToSuperview().offset(-20)
            make.height.equalTo(100)
            make.bottomMargin.equalToSuperview().offset(-5)
        })
        titleLb.snp.makeConstraints({(make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
        })
    }
    
    func setItem(titleValue: String) {
        titleLb.text = titleValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
