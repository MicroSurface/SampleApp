//
//  ComplexTableDataModel.swift
//  SampleApp
//
//  Created by Frank on 2020/4/10.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation
class ComplexTableDataModel {
    var complexData: [ComplexItem] = []
    init() {
        decodeJsonData()
    }
    private func decodeJsonData() {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "complextableview", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            do {
                let body = try JSONDecoder().decode(ComplexListData.self, from: jsonData!)
                complexData = body.result
            } catch {
                print("Fail to decode json: \(error)")
            }
        } else {
            print("Fail find target file")
        }
    }
}

struct ComplexListData: Codable {
    let result: [ComplexItem]
    enum CodingKeys: String, CodingKey {
        case result = "result"
    }
}

struct ComplexItem: Codable {
    let title: String
    let type: String
    let content: [ComplexItemPart]
    enum CodingKeys: String, CodingKey {
        case title, type, content
    }
}

struct ComplexItemPart: Codable {
    let tag: String
    let name: String
    let description: String
    enum CodingKeys: String, CodingKey {
        case tag, name, description
    }
}


