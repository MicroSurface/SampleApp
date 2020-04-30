//
//  TableSelectionDataModel.swift
//  SampleApp
//
//  Created by Frank on 2020/3/31.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation

class TableSelectionDataModel {
    var selectionData: [SelectionData]?
    init() {
        decodeJsonData()
    }
    private func decodeJsonData() {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "tableviewselection", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            do {
                let body = try JSONDecoder().decode(TableSelectionData.self, from: jsonData!)
                selectionData = body.configuration
            } catch {
                print("Fail to decode json")
            }
        } else {
            print("Fail find target file")
        }
    }
}

struct TableSelectionData: Codable {
    let configuration: [SelectionData]
    enum CodingKeys: String, CodingKey {
        case configuration = "tableview_selection"
    }
}

struct SelectionData: Codable {
    let title: String
    enum CodingKeys: String, CodingKey {
        case title
    }
}
