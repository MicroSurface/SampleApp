//
//  WaterfallLayout.swift
//  SampleApp
//
//  Created by Frank on 2020/4/17.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class WaterfallLayout: UICollectionViewFlowLayout {
    let dataItem: [WaterfallDataItem]
    var attributeArray: [UICollectionViewLayoutAttributes] = []
    init(item: [WaterfallDataItem]) {
        dataItem = item
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepare() {
        super.prepare()
        self.scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = 10
        let marginBetween: CGFloat = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        var queueHeight: (firstCol: CGFloat, secondCol: CGFloat) = (0.0, 0.0)
        let itemWidth = (SCREEN_WIDTH - sectionInset.left - sectionInset.right - marginBetween) / 2
        for (index, data) in dataItem.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            var queue = 0
            let photoHeight: CGFloat = 150.0
            let descriptionWidth = itemWidth - marginBetween
            let descriptionHeight: CGFloat = data.description.getTextHeight(fontSize: 15, width: descriptionWidth)
            let authorHeight: CGFloat = data.author.getTextHeight(fontSize: 15, width: itemWidth)
            let totalHeight = photoHeight + descriptionHeight + authorHeight + 5 + 5 + 20
            if queueHeight.firstCol <= queueHeight.secondCol {
                queueHeight.firstCol += totalHeight + self.minimumLineSpacing
                queue = 0
            } else {
                queueHeight.secondCol += totalHeight + self.minimumLineSpacing
                queue = 1
            }
            let itemPositionY = (queue == 0) ? queueHeight.firstCol - totalHeight : queueHeight.secondCol - totalHeight
            let itemPositionX = CGFloat(queue + 1) * marginBetween + CGFloat(queue) * itemWidth
            attributes.frame.origin = CGPoint(x: itemPositionX, y: itemPositionY)
            attributes.frame.size = CGSize(width: itemWidth, height: totalHeight)
            attributeArray.append(attributes)
        }
        // 确定高度最大的那一列，取中间数，确保滑动范围正确
        if queueHeight.firstCol <= queueHeight.secondCol {
            let itemSizeHeight: CGFloat = queueHeight.secondCol * CGFloat(2) / CGFloat(dataItem.count) - self.minimumLineSpacing
            self.itemSize = CGSize(width: itemWidth, height: itemSizeHeight)
        } else {
            let itemSizeHeight: CGFloat = queueHeight.firstCol * CGFloat(2) / CGFloat(dataItem.count) - self.minimumLineSpacing
            self.itemSize = CGSize(width: itemWidth, height: itemSizeHeight)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
}
