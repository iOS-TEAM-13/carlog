//
//  FirebaseService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/15.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreService {
    static let firestoreService = FirestoreService()
    let db = Firestore.firestore()
    
    func savePosts(post: Post, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(post)
            db.collection("posts").addDocument(data: data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    func loadPosts(completion: @escaping ([Post]?) -> Void) {
        db.collection("posts").getDocuments() { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var posts: [Post] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        let post = try Firestore.Decoder().decode(Post.self, from: document.data())
                        posts.append(post)
                    } catch {
                        completion(nil)
                        return
                    }
                }
                completion(posts)
            }
        }
    }
    
    func saveComment(comment: Comment, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(comment)
            db.collection("comments").addDocument(data: data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    func loadComments(completion: @escaping ([Comment]?) -> Void) {
        db.collection("comments").getDocuments() { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var comments: [Comment] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        let comment = try Firestore.Decoder().decode(Comment.self, from: document.data())
                        comments.append(comment)
                    } catch {
                        completion(nil)
                        return
                    }
                }
                completion(comments)
            }
        }
    }
    
//    func editUserData(post: Post, completion: @escaping (Post?) -> Void) {
//            var result: UserModel?
//
//            db.collection("users").document("y527FpLxOC4LWg2jMO01").updateData ([
//                "id": userID,
//                "name" : name,
//                "animalName" : animalName,
//                "birth" : birth,
//                "gender" : gender,
//                "imageURL" : imageURL,
//                "type" : type
//            ])
//            result = self.dicToObject(objectType: UserModel.self, dictionary: names)
//            completion(result)
//        }
//
//        func deleteInfoDocument() {
//            db.collection("aaa").document("aaa").delete(){ err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("Document successfully updated")
//                }
//            }
//        }
//    }
}
