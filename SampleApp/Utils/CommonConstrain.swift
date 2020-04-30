//
//  CommonConstrain.swift
//  SampleApp
//
//  Created by Frank on 2020/3/30.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit
import SnapKit

class CommonConstrain {
    static func setRootViewSafeAreaConstrain(rootView: UIView, relevantView: UIView) {
        relevantView.snp.makeConstraints { (make) in
            make.top.equalTo(rootView.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(rootView.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(rootView.safeAreaLayoutGuide.snp.rightMargin)
            make.bottom.equalTo(rootView.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}
