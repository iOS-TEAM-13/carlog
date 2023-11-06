//
//  Comment.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct Comment: Codable {
    let id: String? //Post의 ID를 저장하기 위한 속성
    var content: String?
    let userName: String?
    let userEmail: String?
    let timeStamp: String?
}
