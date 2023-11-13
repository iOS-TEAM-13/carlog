import Foundation

import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

final class LoginService {
    static let loginService = LoginService()
    let db = Firestore.firestore()

    func sendPasswordReset(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            var isSuccess = true
            if let error = error {
                print("error: \(error.localizedDescription)")
                isSuccess = false
            } else {
                print("메세지 보내기 성공")
            }
            completion(isSuccess, error)
        }
    }

    // 회원가입
    func signUpUser(email: String, password: String, completion: @escaping (() -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
                return
            }
            if let email = authResult?.user.email {
                FirestoreService.firestoreService.saveUsers(user: User(email: email)) { err in
                    print("err: \(String(describing: err?.localizedDescription))")
                }
            }
            completion()
        }
    }

    // 로그인
    func loginUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            var isSuccess = true
            if let error = error {
                print("로그인 실패: \(error.localizedDescription)")
                isSuccess = false
            } else {
                print("(로그인 성공): \(user?.user.email ?? "사용자 정보 없음")")
            }
            completion(isSuccess, error)
        }
    }

    // 로그인 유지
    func keepLogin(completion: @escaping (FirebaseAuth.User?) -> Void) {
        Auth.auth().addStateDidChangeListener { _, user in
            completion(user)
        }
    }

    // 로그아웃
    func logout(completion: () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }

    // 회원탈퇴
    func quitUser(email: String, completion: @escaping (Error?) -> Void) {
        // 1. Firebase Authentication에서 사용자 삭제
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    // 에러 처리
                    completion(error)
                } else {
                    // 2. 사용자 정보를 이메일을 기반으로 검색하여 Firestore에서 삭제
                    self.db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
                        if let error = error {
                            // 에러 처리
                            completion(error)
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        // 성공
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                    self.db.collection("carParts").whereField("userEmail", isEqualTo: email).getDocuments { querySnapshot, error in
                        if let error = error {
                            // 에러 처리
                            completion(error)
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        // 성공
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                    self.db.collection("cars").whereField("userEmail", isEqualTo: email).getDocuments { querySnapshot, error in
                        if let error = error {
                            // 에러 처리
                            completion(error)
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        // 성공
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                    self.db.collection("drivings").whereField("userEmail", isEqualTo: email).getDocuments { querySnapshot, error in
                        if let error = error {
                            // 에러 처리
                            completion(error)
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        // 성공
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                    self.db.collection("fuelings").whereField("userEmail", isEqualTo: email).getDocuments { querySnapshot, error in
                        if let error = error {
                            // 에러 처리
                            completion(error)
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        // 성공
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            UserDefaults.standard.removeObject(forKey: Auth.auth().currentUser?.email ?? "")
        } else {
            // 사용자가 로그인되어 있지 않음
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "사용자가 로그인되어 있지 않습니다."]))
        }
    }
}
