//
//  WaterfallTableCell.swift
//  SampleApp
//
//  Created by Frank on 2020/4/14.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class WaterfallTableCell: UICollectionViewCell {
    lazy var cellView: UIView = UIView()
    lazy var cellImage: UIView = UIView()
    lazy var cellTitle: UILabel = UILabel()
    lazy var cellName: UILabel = UILabel()
    lazy var cellQuantity: UILabel = UILabel()
    lazy var cellBtn: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        cellView.backgroundColor = .white
        cellView.layer.borderWidth = 1.0
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        cellView.layer.cornerRadius = 5
        cellView.clipsToBounds = true
        self.contentView.addSubview(cellView)
        let cellViewWidth = (SCREEN_WIDTH - 30) / CGFloat(2)
        cellView.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.width.equalTo(cellViewWidth)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        })
        cellImage.backgroundColor = .orange
        cellTitle.font = UIFont.systemFont(ofSize: 15)
        cellTitle.textColor = .black
        cellTitle.numberOfLines = 0
        cellName.font = UIFont.systemFont(ofSize: 15)
        cellName.textColor = .gray
        cellName.numberOfLines = 1
        cellQuantity.font = UIFont.systemFont(ofSize: 15)
        cellQuantity.textColor = .black
        cellQuantity.textAlignment = .right
        cellView.addSubview(cellImage)
        cellView.addSubview(cellTitle)
        cellView.addSubview(cellName)
        cellView.addSubview(cellQuantity)
        cellImage.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(150)
        })
        cellTitle.snp.makeConstraints({ (make) in
            make.top.equalTo(cellImage.snp.bottom).offset(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        })
        cellQuantity.snp.makeConstraints({ (make) in
            make.top.equalTo(cellTitle.snp.bottom).offset(5)
            make.right.equalTo(-10)
            make.width.equalTo(cellViewWidth * 0.2)
            make.bottom.equalTo(-20)
        })
        cellName.snp.makeConstraints({ (make) in
            make.top.equalTo(cellTitle.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(cellQuantity.snp.left).offset(-5)
        })
    }
    
    func setItem(item: WaterfallDataItem) {
        cellTitle.text = item.description
        cellName.text = item.author
        cellQuantity.text = item.thumbsup
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        return super.preferredLayoutAttributesFitting(layoutAttributes)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
