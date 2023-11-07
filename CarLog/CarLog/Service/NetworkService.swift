//
//  NetworkService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/01.
//

import Foundation

import Alamofire

class NetworkService {
    static let service = NetworkService()
    
    // 반경 주유소
    func fetchNearbyGasStation(x: String, y: String, sort: String, prodcd: String, completion: @escaping ([String]?) -> Void) {
        // GET 요청을 보낸다
        let url = "https://www.opinet.co.kr/api/aroundAll.do?code=F231011278&"
        let query = "x=\(x)&y=\(y)&radius=1000&sort=\(sort)&prodcd=\(prodcd)&out=json"
        let urlString = url + query
        
        AF.request(urlString).responseDecodable(of: listResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.result.oil.map{ $0.uniID })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeAddress(gasStation: [CustomGasStation], completion: @escaping ([CustomGasStation]?) -> Void) {
        var result = [CustomGasStation]()
        let dispatchGroup = DispatchGroup()
        for i in 0...gasStation.count - 1 {
            dispatchGroup.enter()
            let baseURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?"
            let query = "query=\(gasStation[i].address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            let urlString = baseURL + query
            
            let headers: HTTPHeaders = [
                "X-NCP-APIGW-API-KEY-ID": "i7ms4hgjyy",
                "X-NCP-APIGW-API-KEY": "JhLmWJgPjiBV2PZ9qCHfbMtetMbuCZ74zxTFFIej"
            ]
            AF.request(urlString, headers: headers).responseDecodable(of: Address.self) { response in
                switch response.result {
                case .success(let data):
                    result.append(CustomGasStation(name: gasStation[i].name, id: gasStation[i].id, tel: gasStation[i].tel, address: gasStation[i].address, carWashYn: gasStation[i].carWashYn, cvsYn: gasStation[i].cvsYn, gisXCoor: Float(data.addresses.first?.x ?? "") ?? 0.0, gisYCoor: Float(data.addresses.first?.y ?? "") ?? 0.0, oilPrice: gasStation[i].oilPrice))
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(result)
        }
    }

    // 주유소 상세정보
    func fetchDetailGasStation(idList: [String], completion: @escaping ([CustomGasStation]?) -> Void) {
        var result = [CustomGasStation]()
        let dispatchGroup = DispatchGroup()

            idList.forEach { id in
                dispatchGroup.enter()

                let baseURL = "https://www.opinet.co.kr/api/detailById.do?code=F231011278&"
                let query = "id=\(id)&out=json"
                let urlString = baseURL + query

                AF.request(urlString).responseDecodable(of: gasStationResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        if let data = data.result.oil.first {
                            result.append(CustomGasStation(name: data.osNm, id: data.uniID, tel: data.tel, address: data.newAdr, carWashYn: data.carWashYn, cvsYn: data.cvsYn, gisXCoor: data.gisXCoor, gisYCoor: data.gisYCoor, oilPrice: data.oilPrice))
                        }
                    case .failure(let error):
                        print(error)
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(result)
            }
    }
}
