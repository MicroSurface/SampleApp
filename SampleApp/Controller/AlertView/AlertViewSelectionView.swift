//
//  AlertViewSelectionView.swift
//  SampleApp
//
//  Created by Frank on 2020/4/30.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class AlertViewSelectionView: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose AlertView"
        self.view.backgroundColor = .white
    }
    
}
