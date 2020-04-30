//
//  ComplexTableView.swift
//  SampleApp
//
//  Created by Frank on 2020/4/9.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class ComplexTableView: UITableViewController {
    var complexData: [ComplexItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Complex Table"
        let complexDataModel = ComplexTableDataModel()
        complexData = complexDataModel.complexData
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = getFooterView()
        self.tableView.backgroundColor = .white
        self.tableView.register(ComplexSection1TableCell.self, forCellReuseIdentifier: "section1")
        self.tableView.register(ComplexSection2TableCell.self, forCellReuseIdentifier: "section2")
    }
    
    private func getFooterView() -> UIView {
        let footerView = UIView()
        let redeemBtn = UIButton()
        let paymentBtn = UIButton()
        footerView.backgroundColor = .white
        footerView.frame.size = CGSize(width: SCREEN_WIDTH, height: 150)
        redeemBtn.layer.cornerRadius = 10
        redeemBtn.backgroundColor = .lightGray
        redeemBtn.alpha = 0.4
        redeemBtn.setTitle("Redeem", for: .normal)
        redeemBtn.setTitleColor(.blue, for: .normal)
        paymentBtn.layer.cornerRadius = 10
        paymentBtn.backgroundColor = .lightGray
        paymentBtn.alpha = 0.4
        paymentBtn.setTitle("Payment", for: .normal)
        paymentBtn.setTitleColor(.blue, for: .normal)
        footerView.addSubview(redeemBtn)
        footerView.addSubview(paymentBtn)
        redeemBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(10)
        })
        paymentBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(redeemBtn.snp.bottom).offset(20)
        })
        return footerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return complexData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let titleLb = UILabel()
        headerView.addSubview(titleLb)
        titleLb.font = UIFont.boldSystemFont(ofSize: 25)
        titleLb.text = complexData![section].title
        titleLb.snp.makeConstraints({ (make) in
            make.height.equalToSuperview()
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        })
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if complexData?[section].type == "purelist" {
            return complexData?[section].content.count ?? 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch complexData?[indexPath.section].type {
        case "header":
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "section1", for: indexPath) as? ComplexSection1TableCell
            guard let cellItem = cell else {
                return UITableViewCell()
            }
            return cellItem
        case "mixed":
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "section2", for: indexPath) as? ComplexSection2TableCell
            cell?.getCollectionData(complexData![indexPath.section].content)
            guard let cellItem = cell else {
                return UITableViewCell()
            }
            return cellItem
        case "purelist":
            let cell = UITableViewCell(style: .default, reuseIdentifier: "purelist1")
            cell.textLabel?.text = complexData![indexPath.section].content[indexPath.row].name
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}
