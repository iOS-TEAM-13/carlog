//
//  User.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct User: Codable {
    let email: String?
    let password: String?
}

//로그인할 때 서버에 저장용도 (중복검사 등등)
