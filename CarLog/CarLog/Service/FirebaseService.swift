//
//  FirebaseService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/15.
//

import Foundation
import Firebase
import FirebaseFirestore

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
//    static func getPosts(completion: @escaping ([Post]?, Error?) -> Void) {
//        Firestore.firestore().collection("posts").getDocuments { querySnapshot, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                var posts: [Post] = []
//                for document in querySnapshot?.documents ?? [] {
//                    do {
//                        var post = try Firestore.Decoder().decode(Post.self, from: document.data())
//                        post.id = document.documentID // Set the ID from the Firestore document ID
//                        posts.append(post)
//                    } catch {
//                        completion(nil, error)
//                        return
//                    }
//                }
//                completion(posts, nil)
//            }
//        }
//    }
    
    func getPostData(completion: @escaping ([Post]?) -> Void) {
        var names: [[String:Any]] = [[:]]
        var posts: [Post]?
        
        db.collection("posts").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(posts) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                print("@@@@@@@@ \(document.data())")
                names.append(document.data())
            }
            print("@@@@@@@@ \(names)")
            names.remove(at: 0)
            posts = self.dictionaryToObject(objectType: Post.self, dictionary: names)
            print("@@@@@@@@@@@@ \(posts)")
            completion(posts) // 성공 시 이름 배열 전달
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
