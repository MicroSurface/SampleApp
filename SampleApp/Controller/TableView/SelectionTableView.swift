//
//  selectionTableView.swift
//  SampleApp
//
//  Created by Frank on 2020/3/31.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class SelectionTableView: UITableViewController {
    var listData: [SelectionData]?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Function"
        self.tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        self.tableView.tableFooterView = UIView()
        let selectionDataModel = TableSelectionDataModel()
        listData = selectionDataModel.selectionData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listData?[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch listData?[indexPath.row].title {
        case "EditableTableView":
            let viewController = EditableTableView()
            self.navigationController?.pushViewController(viewController, animated: true)
        case "ComplexSectionTableView":
            let viewController = ComplexTableView()
            self.navigationController?.pushViewController(viewController, animated: true)
        case "MultipleNodesTableView":
            let viewController = MultipleNodesView()
            self.navigationController?.pushViewController(viewController, animated: true)
        case "WaterfallTableView":
            let viewController = WaterfallView()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }

}
