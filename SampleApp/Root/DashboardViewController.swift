//
//  DashboardViewController.swift
//  SampleApp
//
//  Created by Frank on 2020/3/30.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit
import SnapKit

class DashboardViewController: UIViewController {
    var listData: [Configuration]?
    var demoList: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        demoList = UITableView()
        demoList.delegate = self
        demoList.dataSource = self
        demoList.estimatedRowHeight = 100
        demoList.rowHeight = UITableView.automaticDimension
        demoList.separatorStyle = .none
        demoList.register(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        self.view.addSubview(demoList)
        CommonConstrain.setRootViewSafeAreaConstrain(
            rootView: self.view,
            relevantView: demoList
        )
        getDashBoardData()
    }
    private func getDashBoardData() {
        let dashboardDataModel = DashboardDataModel()
        listData = dashboardDataModel.dashboardData
        demoList.reloadData()
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getListHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = listData?[indexPath.row].title else {
            return UITableViewCell()
        }
        let cell = demoList.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.setItem(titleValue: cellData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listData?[indexPath.row].title == "TableView" {
            let viewController = SelectionTableView()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension DashboardViewController {
    private func getListHeaderView() -> UIView {
        let headerView = UIView()
        let headerTitle = UILabel()
        let pushBtn = UIButton()
        headerTitle.font = UIFont.boldSystemFont(ofSize: 35)
        headerView.backgroundColor = .white
        headerTitle.text = "DemoList"
        headerTitle.textColor = .black
        headerView.addSubview(headerTitle)
        headerView.addSubview(pushBtn)
        headerTitle.snp.makeConstraints({(make) in
            make.centerY.equalToSuperview()
            make.leftMargin.equalToSuperview().offset(20)
        })
        return headerView
    }
    
    @objc private func pushPageAction() {
        let viewController = SelectionTableView()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

