//
//  Post.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct Post {
    let id: UUID
    let title: String
    let content: String
    let image: [String?]
    let comment: [Comment]
}
