//
//  GasStationList.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/22/23.

import Foundation

struct listResponse: Codable {
    let result: GasStationList

    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
    }
}

struct GasStationList: Codable {
    let oil: [GasStationSummary]

    enum CodingKeys: String, CodingKey {
        case oil = "OIL"
    }
}

struct GasStationSummary: Codable {
    let uniID: String
    let pollDivCD: String
    let osNM: String
    let price: Int
    let distance: Float
    let gisX: Float
    let gisY: Float

    enum CodingKeys: String, CodingKey {
        case uniID = "UNI_ID"
        case pollDivCD = "POLL_DIV_CD"
        case osNM = "OS_NM"
        case price = "PRICE"
        case distance = "DISTANCE"
        case gisX = "GIS_X_COOR"
        case gisY = "GIS_Y_COOR"
    }
}
