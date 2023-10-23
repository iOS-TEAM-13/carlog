// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gasStation = try? JSONDecoder().decode(GasStation.self, from: jsonData)

import Foundation

// MARK: - GasStation
struct GasStation: Codable {
    let result: Result

    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    let oil: [Oil]

    enum CodingKeys: String, CodingKey {
        case oil = "OIL"
    }
}

// MARK: - Oil
struct Oil: Codable {
    let uniID, pollDivCo, gpollDivCo, osNm: String
    let carWashYn, cvsYn: String
    let gisXCoor, gisYCoor: Double
    let oilPrice: [OilPrice]

    enum CodingKeys: String, CodingKey {
        case uniID = "UNI_ID"
        case pollDivCo = "POLL_DIV_CO"
        case gpollDivCo = "GPOLL_DIV_CO"
        case osNm = "OS_NM"
        case carWashYn = "CAR_WASH_YN"
        case cvsYn = "CVS_YN"
        case gisXCoor = "GIS_X_COOR"
        case gisYCoor = "GIS_Y_COOR"
        case oilPrice = "OIL_PRICE"
    }
}

// MARK: - OilPrice
struct OilPrice: Codable {
    let prodcd: String
    let price: Int
    let tradeDt: String

    enum CodingKeys: String, CodingKey {
        case prodcd = "PRODCD"
        case price = "PRICE"
        case tradeDt = "TRADE_DT"
    }
}
