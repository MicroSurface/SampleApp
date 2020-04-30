//
//  WaterfallView.swift
//  SampleApp
//
//  Created by Frank on 2020/4/14.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class WaterfallView: UIViewController {
    var collectionView: UICollectionView!
    var waterfallData: [WaterfallDataItem]?
    public var columHeights: [Int: CGFloat] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Waterfall Table"
        self.view.backgroundColor = .white
        let waterfallDataModel = WaterfallTableDataModel.init()
        waterfallData = waterfallDataModel.waterfallData
        let layout = WaterfallLayout(item: waterfallData!)
        collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(WaterfallTableCell.self, forCellWithReuseIdentifier: "waterfallCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.reloadData()
        CommonConstrain.setRootViewSafeAreaConstrain(
            rootView: self.view,
            relevantView: collectionView
        )
    }
}

extension WaterfallView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return waterfallData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "waterfallCell", for: indexPath) as! WaterfallTableCell
        cell.setItem(item: waterfallData![indexPath.row])
        return cell
    }
}
