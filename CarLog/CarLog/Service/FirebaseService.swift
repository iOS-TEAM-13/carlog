//
//  FirebaseService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/15.
//
import Foundation

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreService {
    static let firestoreService = FirestoreService()
    
    let db = Firestore.firestore()
    
    // MARK: - User
    
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
    
    func loadUsers(completion: @escaping ([User]?) -> Void) {
        db.collection("users").getDocuments { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var users: [User] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        let user = try Firestore.Decoder().decode(User.self, from: document.data())
                        users.append(user)
                    } catch {
                        completion(nil)
                        return
                    }
                }
                completion(users)
            }
        }
    }
    
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
    
    func checkDuplicate(car: String, data: String, completion: @escaping (Bool, Error?) -> Void) {
        let usersRef = db.collection("cars")
        
        // Firestore에서 모든 사용자 cars 정보 가져오기
        usersRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                return
            }
            
            var isCarAvailable = true
            
            for document in querySnapshot?.documents ?? [] {
                if let existingCar = document.data()["\(data)"] as? String {
                    if existingCar == car {
                        isCarAvailable = false
                        break
                    }
                }
            }
            completion(isCarAvailable, nil)
        }
    }
    
    // MARK: - Post
    
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
    
    func updatePosts(postID: String, emergency: [String?: Bool?]) {
        db.collection("posts").whereField("id", isEqualTo: postID).getDocuments { querySnapshot, _ in
            for document in querySnapshot!.documents {
                self.db.collection("posts").document(document.documentID).updateData(["emergency": emergency]) { _ in
                }
            }
        }
    }
    
    func updatePosts(post: Post) {
        if post.image == [] {
            db.collection("posts").whereField("id", isEqualTo: post.id ?? "").getDocuments { querySnapshot, _ in
                for document in querySnapshot!.documents {
                    self.db.collection("posts").document(document.documentID).updateData([
                        "title": post.title ?? "",
                        "content": post.content ?? ""])
                    { _ in
                    }
                }
            }
        } else {
            db.collection("posts").whereField("id", isEqualTo: post.id ?? "").getDocuments { querySnapshot, _ in
                for document in querySnapshot!.documents {
                    self.db.collection("posts").document(document.documentID).updateData([
                        "title": post.title ?? "",
                        "content": post.content ?? "",
                        "image": post.image.map { $0?.absoluteString }])
                    { _ in
                    }
                }
            }
        }
    }
    
    func loadPosts(excludingBlockedPostsFor userEmail: String, completion: @escaping ([Post]?) -> Void) {
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { userDocSnapshot, userError in
            if let userError = userError {
                print("사용자 문서를 가져오지 못했습니다: \(userError.localizedDescription)")
                completion(nil)
                return
            }
                
            guard let document = userDocSnapshot?.documents.first else {
                print("사용자 문서가 없습니다.")
                completion(nil)
                return
            }
                
            var blockedUsers: [String] = []
            var blockedPosts: [String] = []
                
            if let userBlockedUsers = document.data()["blockedUsers"] as? [String], !userBlockedUsers.isEmpty {
                blockedUsers = userBlockedUsers
            }
                
            if let userBlockedPosts = document.data()["blockedPosts"] as? [String], !userBlockedPosts.isEmpty {
                blockedPosts = userBlockedPosts
            }
                
            let query = self.db.collection("posts").order(by: "timeStamp", descending: true)
                
            query.getDocuments { querySnapshot, error in
                if let error = error {
                    print("게시글을 가져오지 못했습니다: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                    
                var posts: [Post] = []
                    
                for document in querySnapshot?.documents ?? [] {
                    let datas = document.data()
                        
                    if let userName = datas["userName"] as? String, blockedUsers.contains(userName) {
                        continue
                    }
                        
                    if let postId = datas["id"] as? String, blockedPosts.contains(postId) {
                        dump("blockedPosts = \(blockedPosts)")
                        dump("documentID = \(document.documentID)")
                        continue
                    }
                        
                    do {
                        let post = try Firestore.Decoder().decode(Post.self, from: document.data())
                        posts.append(post)
                    } catch let decodeError {
                        print("게시글 디코딩 실패: \(decodeError.localizedDescription)")
                    }
                }
                    
                dump("posts: \(posts)")
                completion(posts)
            }
        }
    }
    
    func blockUser(userName: String, userEmail: String, completion: @escaping (Error?) -> Void) {
        let userQuery = db.collection("users").whereField("email", isEqualTo: userEmail)
            
        userQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print("사용자 문서를 가져오지 못했습니다")
                completion(error)
                return
            }
                
            guard let document = querySnapshot?.documents.first else {
                print("사용자 문서가 없습니다")
                let notFoundError = NSError(domain: "BlockPost", code: 404, userInfo: nil)
                completion(notFoundError)
                return
            }
                
            let userDocRef = self.db.collection("users").document(document.documentID)
            userDocRef.updateData(["blockedUsers": FieldValue.arrayUnion([userName])]) { error in
                if let error = error {
                    print("유저 차단 업데이트 실패")
                }
                completion(error)
            }
        }
    }
        
    func blockPost(postID: String, userEmail: String, completion: @escaping (Error?) -> Void) {
        let userQuery = db.collection("users").whereField("email", isEqualTo: userEmail)
            
        userQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print("사용자 문서를 가져오지 못했습니다: \(error.localizedDescription)")
                completion(error)
                return
            }
                
            guard let document = querySnapshot?.documents.first else {
                print("사용자 문서가 없습니다.")
                let notFoundError = NSError(domain: "BlockPost", code: 404, userInfo: nil)
                completion(notFoundError)
                return
            }
                
            // 차단된 게시글 업데이트
            let userDocRef = self.db.collection("users").document(document.documentID)
            userDocRef.updateData(["blockedPosts": FieldValue.arrayUnion([postID])]) { error in
                if let error = error {
                    print("게시글 차단 업데이트 실패: \(error.localizedDescription)")
                }
                completion(error)
            }
        }
    }
        
    // MARK: - Comment
        
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
        
    func loadComments(excludingBlockedPostsFor userEmail: String, postID: String, completion: @escaping ([Comment]?) -> Void) {
            db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { userDocSnapshot, userError in
                
                if let userError = userError {
                    print("사용자 문서를 가져오지 못했습니다: \(userError.localizedDescription)")
                    completion(nil)
                    return
                }
                    
                guard let document = userDocSnapshot?.documents.first else {
                    print("사용자 문서가 없습니다.")
                    completion(nil)
                    return
                }
                
                var blockedUsers: [String] = []
                var blockedComments: [String] = []
                
                if let userBlockedUsers = document.data()["blockedUsers"] as? [String], !userBlockedUsers.isEmpty {
                    blockedUsers = userBlockedUsers
                }
                
                if let userBlockedComments = document.data()["blockedComments"] as? [String], !userBlockedComments.isEmpty {
                    blockedComments = userBlockedComments
                }
                    
                self.db.collection("comments").whereField("postId", isEqualTo: postID).getDocuments { querySnapshot, error in
                    if let error = error {
                        print("데이터를 가져오지 못했습니다: \(error)")
                        completion(nil)
                    } else {
                        var comments: [Comment] = []
                        
                        for document in querySnapshot?.documents ?? [] {
                            let datas = document.data()
                            
                            if let userName = datas["userName"] as? String, blockedUsers.contains(userName) {
                                continue
                            }
                            
                            if let userNamceForComment = datas["userName"] as? String,
                               blockedComments.contains(userNamceForComment)
                            {
                                continue
                            }
                            
                            do {
                                let comment = try Firestore.Decoder().decode(Comment.self, from: document.data())
                                comments.append(comment)
                            } catch {
                                print("댓글 디코딩 실패: \(error.localizedDescription)")
                                return
                            }
                        }
                        completion(comments)
                    }
                }
            }
        }
    
    func blockComment(commentId: String, userEmail: String, completion: @escaping (Error?) -> Void) {
        let userQuery = db.collection("users").whereField("email", isEqualTo: userEmail)
        
        userQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print("사용자 문서를 가져오지 못했습니다")
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                print("사용자 문서가 없습니다")
                let notFoundError = NSError(domain: "BlockComment", code: 404, userInfo: nil)
                completion(notFoundError)
                return
            }
            
            let userDocRef = self.db.collection("users").document(document.documentID)
            userDocRef.updateData(["blockedComments": FieldValue.arrayUnion([commentId])]) { error in
                if let error = error {
                    print("코멘트 차단 업데이트 실패")
                }
                completion(error)
            }
        }
    }
        
    func removeComment(commentId: String, completion: @escaping (Error?) -> Void) {
        db.collection("comments").whereField("id", isEqualTo: commentId)
            .getDocuments { querySnapshot, _ in
                for document in querySnapshot!.documents {
                    self.db.collection("comments").document(document.documentID).delete()
                }
            }
    }
        
    func removePost(postID: String, completion: @escaping (Error?) -> Void) {
        let postsCollection = db.collection("posts")
        let postQuery = postsCollection.whereField("id", isEqualTo: postID)
            
        let commensCollection = db.collection("comments")
        let commentQuery = commensCollection.whereField("postId", isEqualTo: postID)
            
        postQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print("포스트를 조회하는 중 오류 발생: \(error)")
                completion(error)
                return
            }
            for document in querySnapshot!.documents {
                document.reference.delete()
            }
        }
            
        commentQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print("댓글을 조회하는 중 오류 발생: \(error)")
                completion(error)
                return
            }
            for document in querySnapshot!.documents {
                document.reference.delete()
            }
        }
    }
        
    // MARK: - Car
        
    func saveCar(car: Car, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(car)
            db.collection("cars").document(Constants.currentUser.userEmail ?? "").setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
        
    func loadCar(completion: @escaping ([Car]?) -> Void) {
        db.collection("cars").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var cars: [Car] = []
                for document in querySnapshot?.documents ?? [] {
                    do {
                        let car = try Firestore.Decoder().decode(Car.self, from: document.data())
                        cars.append(car)
                    } catch {
                        completion(nil)
                        return
                    }
                }
                completion(cars)
            }
        }
    }
        
    // MARK: - CarParts
        
    func saveCarPart(carPart: CarPart, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(carPart)
            db.collection("carParts").document(Constants.currentUser.userEmail ?? "").setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
        
    func loadCarPart(completion: @escaping (CarPart?) -> Void) {
        db.collection("carParts").document(Auth.auth().currentUser?.email ?? "").getDocument { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var carParts: CarPart?
                do {
                    let carPart = try Firestore.Decoder().decode(CarPart.self, from: querySnapshot?.data() ?? CarPart(parts: []))
                    carParts = carPart
                } catch {
                    completion(nil)
                    return
                }
                completion(carParts)
            }
        }
    }
    
    // MARK: - Driving / timeStamp를 Date로 변환하고, 그걸 다시 String으로 변환하는데 없으면 거기다가 현재 시간을 넣어라 / currentTime값이 nil인 경우를 위해 if let 사용
        
    func saveDriving(driving: Driving, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(driving)
                
            var documentID = ""
                
            if let currentTime = driving.timeStamp?.toDate()?.toStringDetail() {
                documentID = "\(currentTime)_\(Constants.currentUser.userEmail ?? "")"
            } else {
                documentID = "\(Date().toStringDetail())_\(Constants.currentUser.userEmail ?? "")"
            }
                
            db.collection("drivings").document(documentID).setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
        
    func loadDriving(completion: @escaping ([Driving]?) -> Void) {
        db.collection("drivings").whereField("userEmail", isEqualTo: Constants.currentUser.userEmail ?? "").getDocuments { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var drivings: [Driving] = []
                for document in querySnapshot?.documents ?? [] {
                    if var drivingData = try? Firestore.Decoder().decode(Driving.self, from: document.data()) {
                        drivingData.documentID = document.documentID
                        drivings.append(drivingData)
                    }
                }
                completion(drivings)
            }
        }
    }
        
    func updateDriving(drivingID: String, updatedData: [String: Any], completion: @escaping (Error?) -> Void) {
        let documentReference = db.collection("drivings").document(drivingID)
            
        documentReference.updateData(updatedData) { error in
            if let error = error {
                print("업데이트 못했어요.: \(error)")
                completion(error)
            } else {
                print("업데이트 했어요.")
                completion(nil)
            }
        }
    }
        
    func removeDriving(drivingID: String, completion: @escaping (Error?) -> Void) {
        db.collection("drivings").document(drivingID).delete { error in
            if let error = error {
                print("주행 데이터를 삭제하지 못했습니다.: \(error)")
                completion(error)
            } else {
                print("주행 데이터를 성공적으로 삭제했습니다.")
                completion(nil)
            }
        }
    }
        
    // MARK: - Fueling
        
    func saveFueling(fueling: Fueling, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(fueling)
                
            var documentID = ""
                
            if let currentTime = fueling.timeStamp?.toDate()?.toStringDetail() {
                documentID = "\(currentTime)_\(Constants.currentUser.userEmail ?? "")"
            } else {
                documentID = "\(Date().toStringDetail())_\(Constants.currentUser.userEmail ?? "")"
            }
                
            db.collection("fuelings").document(documentID).setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
        
    func loadFueling(completion: @escaping ([Fueling]?) -> Void) {
        db.collection("fuelings").whereField("userEmail", isEqualTo: Constants.currentUser.userEmail ?? "").getDocuments { querySnapshot, error in
            if let error = error {
                print("데이터를 가져오지 못했습니다: \(error)")
                completion(nil)
            } else {
                var fuelings: [Fueling] = []
                for document in querySnapshot?.documents ?? [] {
                    if var fuelingData = try? Firestore.Decoder().decode(Fueling.self, from: document.data()) {
                        fuelingData.documentID = document.documentID
                        fuelings.append(fuelingData)
                    }
                }
                completion(fuelings)
            }
        }
    }
        
    func updateFueling(fuelingID: String, updatedData: [String: Any], completion: @escaping (Error?) -> Void) {
        let documentReference = db.collection("fuelings").document(fuelingID)
            
        documentReference.updateData(updatedData) { error in
            if let error = error {
                print("업데이트 못했어요.: \(error)")
                completion(error)
            } else {
                print("업데이트 했어요.")
                completion(nil)
            }
        }
    }
        
    func removeFueling(fuelingID: String, completion: @escaping (Error?) -> Void) {
        db.collection("fuelings").document(fuelingID).delete { error in
            if let error = error {
                print("주행 데이터를 삭제하지 못했습니다.: \(error)")
                completion(error)
            } else {
                print("주행 데이터를 성공적으로 삭제했습니다.")
                completion(nil)
            }
        }
    }
}
