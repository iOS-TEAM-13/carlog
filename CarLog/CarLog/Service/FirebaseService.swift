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
    
    func fetchNickName(userEmail: String, completion: @escaping (String?) -> Void) {
            Firestore.firestore().collection("cars").whereField("userEmail", isEqualTo: userEmail).getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    completion(nil)
                } else {
                    if let document = querySnapshot?.documents.first {
                        let nickName = document.data()["nickName"] as? String
                        completion(nickName)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    
    // MARK: - Comment

    func saveCommentToPost(field: String, value: String, comment: Comment, completion: @escaping (Error?) -> Void) {
        db.collection("posts").whereField(field, isEqualTo: value).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(error)
            } else {
                if let querySnapshot = querySnapshot, querySnapshot.documents.count > 0 {
                    // 쿼리 결과가 있다면 첫 번째 문서를 사용합니다.
                    // 실제 애플리케이션에서는 이 방법이 여러 문서를 반환할 수 있으므로 추가 로직이 필요할 수 있습니다.
                    let document = querySnapshot.documents.first
                    let documentID = document?.documentID ?? ""
                    
                    // 이제 문서 ID를 가지고 댓글을 추가할 수 있습니다.
                    let commentData = [
                        "content": comment.content,
                        "userName": comment.userName,
                        "userEmail": comment.userEmail,
                        "timeStamp": comment.timeStamp
                    ]
                    
                    let commentsRef = self.db.collection("posts").document(documentID).collection("comments")
                    commentsRef.addDocument(data: commentData as [String : Any]) { error in
                        if let error = error {
                            print("Error writing comment: \(error)")
                            completion(error)
                        } else {
                            print("Document successfully written!")
                            completion(nil)
                        }
                    }
                } else {
                    // 문서를 찾을 수 없습니다.
                    print("No documents found")
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No documents found matching the criteria"])
                    completion(error)
                }
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
    
    // MARK: - Car

    func saveCar(car: Car, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(car)
            db.collection("cars").document(Auth.auth().currentUser?.email ?? "").setData(data) { error in
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
            db.collection("carParts").document(Auth.auth().currentUser?.email ?? "").setData(data) { error in
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
                documentID = "\(currentTime)_\(Auth.auth().currentUser?.email ?? "")"
            } else {
                documentID = "\(Date().toStringDetail())_\(Auth.auth().currentUser?.email ?? "")"
            }

            db.collection("drivings").document(documentID).setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    func loadDriving(completion: @escaping ([Driving]?) -> Void) {
        db.collection("drivings").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments { querySnapshot, error in
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
                documentID = "\(currentTime)_\(Auth.auth().currentUser?.email ?? "")"
            } else {
                documentID = "\(Date().toStringDetail())_\(Auth.auth().currentUser?.email ?? "")"
            }

            db.collection("fuelings").document(documentID).setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    func loadFueling(completion: @escaping ([Fueling]?) -> Void) {
        db.collection("fuelings").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments { querySnapshot, error in
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
