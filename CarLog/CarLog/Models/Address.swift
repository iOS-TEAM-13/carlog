//
//  Adress.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/01.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let status: String
    let meta: Meta
    let addresses: [AddressElement]
    let errorMessage: String
}

// MARK: - AddressElement
struct AddressElement: Codable {
    let roadAddress, jibunAddress, englishAddress: String
    let addressElements: [AddressElementElement]
    let x, y: String
    let distance: Int
}

// MARK: - AddressElementElement
struct AddressElementElement: Codable {
    let types: [String]
    let longName, shortName, code: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount, page, count: Int
}

