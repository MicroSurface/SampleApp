//
//  WaterfallTableDataModel.swift
//  SampleApp
//
//  Created by Frank on 2020/4/17.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation

class WaterfallTableDataModel {
    var waterfallData: [WaterfallDataItem] = []
    init() {
        decodeJsonData()
    }
    private func decodeJsonData() {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "waterfalltableview", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            do {
                let body = try JSONDecoder().decode(WaterfallData.self, from: jsonData!)
                waterfallData = body.result
            } catch {
                print("Fail to decode json: \(error)")
            }
        } else {
            print("Fail find target file")
        }
    }
}

struct WaterfallData: Codable {
    let result: [WaterfallDataItem]
    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct WaterfallDataItem: Codable {
    let description: String
    let author: String
    let thumbsup: String
    enum CodingKeys: String, CodingKey {
        case description, author, thumbsup
    }
}
