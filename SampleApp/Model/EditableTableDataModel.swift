//
//  EditableTableDataModel.swift
//  SampleApp
//
//  Created by Frank on 2020/4/2.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation

class EditableTableDataModel {
    var editableData: [EditableDataList] = []
    var sectionTableData: [[EditableDataList]] = []
    init() {
        decodeJsonData()
        getGroupData()
    }
    private func decodeJsonData() {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "editabletableview", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            do {
                let body = try JSONDecoder().decode(EditableTableData.self, from: jsonData!)
                editableData = body.result
            } catch {
                print("Fail to decode json: \(error)")
            }
        } else {
            print("Fail find target file")
        }
    }
    private func getGroupData() {
        if editableData.isEmpty {
            return
        }
        var selectedList: [EditableDataList] = []
        var nonSelectedList: [EditableDataList] = []
        for data in editableData {
            if data.isSelected {
                selectedList.append(data)
            } else {
                nonSelectedList.append(data)
            }
        }
        sectionTableData.append(selectedList)
        sectionTableData.append(nonSelectedList)
    }
}

class EditableTableData: Codable {
    let result: [EditableDataList]
    enum CodingKeys: String, CodingKey {
        case result
    }
}

class EditableDataList: Codable {
    let title: String
    var isSelected: Bool
    var isConcerned: Bool
    enum CodingKeys: String, CodingKey {
        case title
        case isSelected = "is_selected"
        case isConcerned = "is_concerned"
    }
}


