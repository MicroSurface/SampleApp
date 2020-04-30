//
//  CollectionViewCell.swift
//  SampleApp
//
//  Created by Frank on 2020/4/13.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    lazy var cellView: UIView = UIView()
    lazy var cellImage: UIView = UIView()
    lazy var cellName: UILabel = UILabel()
    lazy var cellDescription: UILabel = UILabel()
    lazy var cellButton: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(cellView)
        cellView.addSubview(cellImage)
        cellImage.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 80/255, alpha: 1.0)
        cellImage.layer.cornerRadius = 10
        cellName.font = UIFont.systemFont(ofSize: 17)
        cellDescription.font = UIFont.systemFont(ofSize: 14)
        cellDescription.textColor = .gray
        cellButton.layer.cornerRadius = 15
        cellButton.setTitle("Pay", for: .normal)
        cellButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 205/255, alpha: 1.0), for: .normal)
        cellButton.backgroundColor = .lightGray
        cellButton.alpha = 0.4
        cellView.addSubview(cellName)
        cellView.addSubview(cellDescription)
        cellView.addSubview(cellButton)
        cellView.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.height.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
        })
        cellImage.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(0)
            make.width.equalTo(cellView.snp.height)
        })
        cellName.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(cellImage.snp.right).offset(20)
            make.right.equalTo(cellButton.snp.left).offset(-10)
        })
        cellDescription.snp.makeConstraints({ (make) in
            make.top.equalTo(cellName.snp.bottom).offset(10)
            make.left.equalTo(cellName.snp.left)
            make.right.equalTo(cellButton.snp.left).offset(-10)
        })
        cellButton.snp.makeConstraints({ (make) in
            make.right.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        })
    }
    
    func setItem(_ data: ComplexItemPart) {
        cellName.text = data.name
        cellDescription.text = data.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
