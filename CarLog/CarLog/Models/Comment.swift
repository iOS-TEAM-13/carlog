//
//  Comment.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct Comment: Codable {
    let id: String?
    let postId: String?
    var content: String?
    let userName: String?
    let userEmail: String?
    let timeStamp: String?
}

    //db.collection("comments").whereField(postId, isEqualTo: selectedPost.id ?? "")

// static let userEmail= Auth.auth().currentUser().email -> 저장해둘지 말지 (효율성)
