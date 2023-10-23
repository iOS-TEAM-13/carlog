//
//  NetworkManager.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/23/23.
//

import Foundation

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
}
