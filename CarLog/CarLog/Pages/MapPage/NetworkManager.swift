//
//  NetworkManager.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/23/23.
//

import Foundation

import Alamofire

class NetworkManager {
    //반경 내 주유소 api 파싱
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
    
    func fetchCoordinateChange(fromLat lat: String, fromLon lon: String, completion: @escaping (Coordinate?) -> Void) {
        
        let baseURL = "https://apis.openapi.sk.com/tmap/geo/coordconvert?"
        let query = "version=1&lat=\(lat)&lon=\(lon)&fromCoord=WGS84GEO&toCoord=KATECH"
        let urlString = baseURL + query
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("BeMTJ14vQC3i9AJsnlu3I3ZXQgODCxUd1bUeihFm", forHTTPHeaderField: "appkey")
        
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
                    let decodedData = try JSONDecoder().decode(Coordinate.self, from: data!)
                    completion(decodedData)
                    
                default :

                    print("200번대 아님")
                    completion(nil)
                }
            } catch {
                print("디코딩 실패")
                completion(nil)
            }
        }
        task.resume()
    }
    //주유소 상세정보 api 파싱
    func fetchGasStationDetailList(id: String,completion: @escaping (gasStationResponse?) -> Void){
        // GET 요청을 보낸다
        let baseURL = "https://www.opinet.co.kr/api/detailById.do?code=F231013280&"
        let query = "id=\(id)&out=json"
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
                    let decodedData = try JSONDecoder().decode(gasStationResponse.self, from: data!)
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
    
    func fetchCoordinateChangeAgain(fromLat lat: String, fromLon lon: String, completion: @escaping (ReverseCoordinate?) -> Void) {
        
        let baseURL = "https://apis.openapi.sk.com/tmap/geo/coordconvert?"
        let query = "version=1&lat=\(lat)&lon=\(lon)&fromCoord=KATECH&toCoord=WGS84GEO"
        let urlString = baseURL + query
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("BeMTJ14vQC3i9AJsnlu3I3ZXQgODCxUd1bUeihFm", forHTTPHeaderField: "appkey")
        
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
                    let decodedData = try JSONDecoder().decode(ReverseCoordinate.self, from: data!)
                    completion(decodedData)
                    
                default :

                    print("200번대 아님")
                    completion(nil)
                }
            } catch {
                print("디코딩 실패")
                completion(nil)
            }
        }
        task.resume()

    }
}
