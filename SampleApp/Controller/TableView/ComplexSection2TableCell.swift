//
//  ComplexSection2TableCell.swift
//  SampleApp
//
//  Created by Frank on 2020/4/10.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class ComplexSection2TableCell: UITableViewCell {
    var contentData: [ComplexItemPart]?
    lazy var testView = UIView()
    var pageing = UIPageControl()
    var collectionView: UICollectionView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(testView)
        testView.snp.makeConstraints({ (make) in
            make.height.equalTo(300)
            make.left.right.equalTo(0)
            make.top.bottom.equalTo(0)
        })
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        testView.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.reloadData()
    }
    
    func getCollectionData(_ data: [ComplexItemPart]) {
        contentData = data
        collectionView.reloadData()
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

extension ComplexSection2TableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .blue
        cell.setItem(contentData![indexPath.row])
        return cell
    }
}
