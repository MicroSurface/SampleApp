//
//  EditableTableView.swift
//  SampleApp
//
//  Created by Frank on 2020/3/31.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class EditableTableView: UITableViewController {
    var listData: [[EditableDataList]]?
    var isEditingTableView: Bool = false
    var snapShotView: UIView?
    var sourceIndexPath: IndexPath?
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        let item = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(clickToEdit(sender:))
        )
        self.navigationItem.rightBarButtonItem = item
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Table Cell"
        let editDataModel = EditableTableDataModel.init()
        listData = editDataModel.sectionTableData
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        self.tableView.register(EditableTableCell.self, forCellReuseIdentifier: "editableCell")
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(sender:)))
        self.tableView.addGestureRecognizer(longPressRecognizer)
    }
    // MARK: 长按拖动Cell
    @objc private func longPressAction(sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: touchPoint) else {
            return
        }
        switch sender.state {
        case .began:
            sourceIndexPath = indexPath
            let cell = self.tableView.cellForRow(at: indexPath)
            snapShotView = getSnapShotForCell(inputView: cell!)
            var center = cell?.center
            snapShotView?.center = center!
            snapShotView?.alpha = 0.0
            self.tableView.addSubview(snapShotView!)
            UIView.animate(withDuration: 0.25, animations: {
                center?.y = touchPoint.y
                self.snapShotView?.center = center!
                /*
                 newX = ax + cy + tX (x = 100, y = 100)
                 newY = bx + dy + tY (x = 100, y = 100)
                 得出的值按照比例进行缩放
                 e.g.->
                 a = 0.5, d = 0.5, tX = 0, tY = 0
                 newX = 50%
                 newY = 50%
                 tX > 0, 会向X轴正方向平移
                 tY > 0, 会向y轴正方向平移（向下）
                 */
                self.snapShotView?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.snapShotView?.alpha = 0.98
                cell?.alpha = 0.0
            }, completion: { (finished) in
                cell?.isHidden = true
            })
            break
        case .changed:
            var center = snapShotView?.center
            center?.y = touchPoint.y
            snapShotView?.center = center!
            if !(indexPath.elementsEqual(sourceIndexPath!)) && indexPath.section == sourceIndexPath?.section {
                self.tableView.moveRow(at: sourceIndexPath!, to: indexPath)
                sourceIndexPath = indexPath
            }
            break
        case .ended:
            let cell = self.tableView.cellForRow(at: sourceIndexPath!)
            cell?.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: {
                self.snapShotView?.center = cell!.center
                self.snapShotView?.alpha = 0.0
                cell?.alpha = 1.0
                cell?.backgroundColor = .white
            }, completion: { (finished) in
                cell?.isHidden = false
                self.sourceIndexPath = nil
                self.snapShotView?.removeFromSuperview()
                self.snapShotView = nil
            })
            break
        default:
            break
        }
    }
    
    @objc private func clickToEdit(sender: UIBarButtonItem) {
        isEditingTableView = !isEditingTableView
        sender.title = isEditingTableView ? "Done" : "Edit"
        self.tableView.setEditing(isEditingTableView, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listData?.count ?? 0
    }
    
    private func getSnapShotForCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let snapShot = UIImageView(image: image)
        snapShot.layer.masksToBounds = false
        snapShot.layer.cornerRadius = 0.0
        snapShot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapShot.layer.shadowOpacity = 0.4
        return snapShot
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        let headerTitle = UILabel()
        headerTitle.font = UIFont.boldSystemFont(ofSize: 18)
        if section == 0 {
            headerTitle.text = "Edit cell"
        } else {
            headerTitle.text = "Swipe to add"
        }
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints({(make) in
            make.leftMargin.equalTo(20)
            make.centerY.equalToSuperview()
        })
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if listData![section].isEmpty {
            return 0.0
        } else {
            return 50.0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = listData?[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "editableCell", for: indexPath) as! EditableTableCell
        cell.setItem(item: data)
        if traitCollection.forceTouchCapability == .available {
            
        }
        return cell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.forceTouchCapability == .available {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: 带有加减号的删除和增加
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .delete
        } else {
            return .insert
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedData = listData![indexPath.section][indexPath.row]
            listData?[indexPath.section + 1].insert(deletedData, at: indexPath.row)
            listData?[indexPath.section].remove(at: indexPath.row)
        } else if editingStyle == .insert {
            let insertedData = listData![indexPath.section][indexPath.row]
            listData?[indexPath.section - 1].insert(insertedData, at: indexPath.row)
            listData?[indexPath.section].remove(at: indexPath.row)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    // MARK: 自定义多个Cell操作按钮
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let concernAction:UITableViewRowAction = UITableViewRowAction(
            style: .default,
            title: listData![indexPath.section][indexPath.row].isConcerned ? "Deconcern" : "Concern",
            handler: {(action, indexPath) in
                self.listData![indexPath.section][indexPath.row].isConcerned = !self.listData![indexPath.section][indexPath.row].isConcerned
                tableView.reloadData()
            }
        )
        concernAction.backgroundColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
        let deleteAction:UITableViewRowAction = UITableViewRowAction(
            style: .default,
            title: "Delete",
            handler: {(action, indexPath) in
                self.listData?[indexPath.section][indexPath.row].isSelected = false
                let deletedData = self.listData![indexPath.section][indexPath.row]
                self.listData?[indexPath.section + 1].insert(deletedData, at: 0)
                self.listData?[indexPath.section].remove(at: indexPath.row)
                tableView.reloadData()
            }
        )
        let reSequenceAction:UITableViewRowAction = UITableViewRowAction(
            style: .default,
            title: "Sequence",
            handler: {(action, indexPath) in
                if indexPath.row + 1 == self.listData![indexPath.section].count {
                    return
                }
                let toIndexPath: IndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                tableView.moveRow(at: indexPath, to: toIndexPath)
            }
        )
        reSequenceAction.backgroundColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
        let addAction:UITableViewRowAction = UITableViewRowAction(
            style: .default,
            title: "Add",
            handler: {(action, indexPath) in
                self.listData![indexPath.section][indexPath.row].isSelected = true
                let insertedData = self.listData![indexPath.section][indexPath.row]
                self.listData?[indexPath.section - 1].insert(insertedData, at: 0)
                self.listData?[indexPath.section].remove(at: indexPath.row)
                tableView.reloadData()
            }
        )
        addAction.backgroundColor = .green
        if indexPath.section == 1 {
            return [addAction]
        } else {
            return [deleteAction, concernAction, reSequenceAction]
        }
    }
}
