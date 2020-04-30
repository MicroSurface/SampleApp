//
//  DashboardDataModel.swift
//  SampleApp
//
//  Created by Frank on 2020/3/31.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation

class DashboardDataModel {
    var dashboardData: [Configuration]?
    init() {
        decodeJsonData()
    }
    private func decodeJsonData() {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "dashboard", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            do {
                let body = try JSONDecoder().decode(DashboardData.self, from: jsonData!)
                dashboardData = body.configuration
            } catch {
                print("Fail to decode json")
            }
        } else {
            print("Fail find target file")
        }
    }
}

struct DashboardData: Codable {
    let configuration: [Configuration]
    enum CodingKeys: String, CodingKey {
        case configuration = "dashboard_configuration"
    }
}

struct Configuration: Codable {
    let title: String
    enum CodingKeys: String, CodingKey {
        case title
    }
}
