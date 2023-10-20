//
//  FirebaseService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/15.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

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
        db.collection("posts").getDocuments { querySnapshot, error in
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
        db.collection("comments").getDocuments { querySnapshot, error in
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
    
    //지훈
    func checkingEmail(email: String, completion: @escaping (Bool, Error?) -> Void) {
        let usersRef = db.collection("users")
        
        // Firestore에서 모든 사용자 이메일 가져오기
        usersRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                return
            }
            
            var isEmailAvailable = true
            
            for document in querySnapshot?.documents ?? [] {
                if let existingemail = document.data()["email"] as? String {
                    if existingemail == email {
                        isEmailAvailable = false
                        break
                    }
                }
            }
            completion(isEmailAvailable, nil)
        }
    }
    
    func saveUsers(user: User, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(user)
            db.collection("users").addDocument(data: data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
    //
    func saveDriving(driving: Driving, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(driving)
            db.collection("drivings").addDocument(data: data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
    func loadDriving(completion: @escaping ([Driving]?) -> Void) {
        db.collection("drivings").whereField("userEmail", in: [Auth.auth().currentUser?.email]).getDocuments { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var drivings: [Driving] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        let driving = try Firestore.Decoder().decode(Driving.self, from: document.data())
                        drivings.append(driving)
                    } catch {
                        completion(nil)
                        return
                    }
                }
                completion(drivings)
            }
        }
    }
}
