import Foundation

// MARK: - Gasstaion

struct gasStationResponse: Codable {
    let result: GasStation
    
    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
    }
}

// MARK: - Result

struct GasStation: Codable {
    let oil: [GasStationDetailSummary]
    
    enum CodingKeys: String, CodingKey {
        case oil = "OIL"
    }
}

// MARK: - Oil

struct GasStationDetailSummary: Codable {
    let uniID: String
    let pollDivCo: String
    let gpollDivCo: String
    let osNm: String
    let vanAdr, newAdr, tel: String
    let carWashYn: String
    let cvsYn: String
    var gisXCoor: Float
    var gisYCoor: Float
    let oilPrice: [OilPrice]
    
    enum CodingKeys: String, CodingKey {
        case uniID = "UNI_ID"
        case pollDivCo = "POLL_DIV_CO"
        case gpollDivCo = "GPOLL_DIV_CO"
        case osNm = "OS_NM"
        case vanAdr = "VAN_ADR"
        case newAdr = "NEW_ADR"
        case tel = "TEL"
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

struct CustomGasStation {
    let name: String
    let id: String
    let tel: String
    let address: String
    let carWashYn: String
    let cvsYn: String
    var gisXCoor: Float
    var gisYCoor: Float
    let oilPrice: [OilPrice]
}
