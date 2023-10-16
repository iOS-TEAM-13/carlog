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
    let db = Firestore.firestore()
//    static func savePost(post: Post, completion: @escaping (Error?) -> Void) {
//        do {
//            let data = try Firestore.Encoder().encode(post)
//            Firestore.firestore().collection("posts").addDocument(data: data) { error in
//                completion(error)
//            }
//        } catch {
//            completion(error)
//        }
//    }
//
    static func getComments(completion: @escaping ([Comment]?) -> Void) {
        Firestore.firestore().collection("comment").getDocuments() { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var posts: [Comment] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        print("@@@@@@@@ data: \(document.data())")
                        
//                        posts.append(Comment(id: UUID(uuidString: document.data()["id"] as! String) ?? UUID(), content: document.data()["content"]  as! String, userId: UUID(uuidString: document.data()["id"] as! String) ?? UUID(), userName: document.data()["userName"] as! String))
                        
                        let post = try Firestore.Decoder().decode(Comment.self, from: document.data())
                        
                        print("@@@@@@@@ post: \(posts)")
//                        posts.append(post)
                    } catch {
                        print("@@@@@@@ catch: \(document.data())")
                        completion(nil)
                        return
                    }
                }
                completion(posts)
            }
        }
    }
    
//    func getPostData(completion: @escaping ([Post]?) -> Void) {
//        var posts: [Post] = [] // 빈 배열로 초기화
//
//        db.collection("posts").getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//                completion(posts) // 호출하는 쪽에 빈 배열 전달
//                return
//            }
//
//            for document in querySnapshot!.documents {
//                        // Firestore 문서 데이터를 Post 타입으로 변환
//
//                if let data = document.data() as? [String: Any],
//                   let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
//                   let post = try? JSONDecoder().decode(Post.self, from: jsonData) {
//                    print("@@@@@@@@@@@@ data: \(data)")
//                    print("@@@@@@@@@@@@ jsonData: \(jsonData)")
//                    print("@@@@@@@@@@@@ post: \(post)")
//                    posts.append(post)
//                }
////                        if let data = document.data() as? [String: Any],
////                           let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
////                           let post = try? JSONDecoder().decode(Post.self, from: jsonData) {
////                            print("@@@@@@@@@@@@ data: \(data)")
////                            print("@@@@@@@@@@@@ jsonData: \(jsonData)")
////                            print("@@@@@@@@@@@@ post: \(post)")
////                            posts.append(post)
////                        }
//                    }
//            completion(posts) // 성공 시 이름 배열 전달
//        }
//    }
    
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

extension FirestoreService {
    func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("@@@@ dict : \(dictionaries[0])")
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        print("@@@@ objc : \(objects)")
        return objects
        
    }
    
    func dicToObject<T:Decodable>(objectType:T.Type,dictionary:[String:Any]) -> T? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode(T.self, from: dictionaries) else { return nil }
        return objects
        
    }
}
