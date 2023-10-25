//
//  NetworkManager.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/23/23.
//

import Foundation

import Alamofire

class NetworkManager {
    func fetchGasStationList(x:String,y:String,sort:String,prodcd:String, completion: @escaping (listResponse?) -> Void){
        // GET 요청을 보낸다
        let baseURL = "https://www.opinet.co.kr/api/aroundAll.do?code=F231013280&"
        let query = "x=\(x)&y=\(y)&radius=5000&sort=\(sort)&prodcd=\(prodcd)&out=json"
        let urlString = baseURL + query
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            do {
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    return
                }
                
                switch urlResponse.statusCode {
                case 200..<300 :
                    let decodedData = try JSONDecoder().decode(listResponse.self, from: data!)
                    completion(decodedData)

                default :
                    print("200번대 아님")
                    completion(nil)
                }
            } catch {
                print("디코딩실패")
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func alamo() {
        let headers: HTTPHeaders = [
          "accept": "application/json",
          "appKey": "BeMTJ14vQC3i9AJsnlu3I3ZXQgODCxUd1bUeihFm"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://apis.openapi.sk.com/tmap/geo/coordconvert?version=1&lat=37.5446283608815&lon=126.83529138565&fromCoord=WGS84GEO&toCoord=WGS84GEO")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        print("@@@@@ url \(request.mainDocumentURL)")
        AF.request("https://api.example.com/data", method: .get, headers: headers)
            .validate() // 응답 유효성을 검사합니다.
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        // 성공적으로 데이터를 받았을 때 처리
                        print("@@@@@ Success: \(data)")
                    }
                case .failure(let error):
                    // 오류 처리
                    print("@@@@@ Error: \(error)")
                }
            }
    }
}
