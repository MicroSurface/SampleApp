//
//  Extensions.swift
//  SampleApp
//
//  Created by Frank on 2020/4/17.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

extension String {
    // 获取文字宽度
    func getTextWidth(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: CGFloat(MAXFLOAT), height: height),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(rect.width)
    }

    func getTextHeight(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(rect.height)
    }

    func getTextHeightWithMaxHeight(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(rect.height) > maxHeight ? maxHeight : ceil(rect.height)
    }
    // 获取具有行间距的字符串高度
    // @fontSize: 字体大小
    // @width: Label宽度
    // @lineSpacing: 行间距，默认为5
    // @align: 显示位置，默认居中显示
    func getLineSpacingStringHeight(fontSize: CGFloat, width: CGFloat, lineSpacing: CGFloat = 5.0, align: NSTextAlignment = .center) -> (text: NSAttributedString, height: CGFloat) {
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
        paraph.lineSpacing = lineSpacing
        paraph.alignment = align
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.paragraphStyle: paraph]
        let attributeText = NSAttributedString(string: self, attributes: attributes)
        let textHeight = attributeText.getAttributedTextHeight(width: width)
        return (attributeText, textHeight)
    }
    // 截取字符串，返回截取到的字符串
    // @startInde: 起始位置
    // @endIndex: 结尾位置
    func interceptString(str: String, startIndex: Int, endIndex: Int) -> String {
        let index1 = str.index(str.startIndex, offsetBy: startIndex)
        let index2 = str.index(str.startIndex, offsetBy: endIndex)
        let result = str[index1..<index2]
        return String(result)
    }
}

extension NSAttributedString {
    func getAttributedTextHeight(width: CGFloat) -> CGFloat {
        let rect = NSAttributedString(attributedString: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            context: nil
        )
        return ceil(rect.height)
    }
}
