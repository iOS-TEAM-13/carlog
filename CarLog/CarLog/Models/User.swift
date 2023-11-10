//
//  User.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

// 로그인할 때 서버에 저장용도 (중복검사 등등)
struct User: Codable {
    let email: String?
    var blockedPosts: [String]?
    var blockedUsers: [String]?
    var blockedComments: [String]?
}
