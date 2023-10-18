import Foundation
import FirebaseAuth
import FirebaseFirestore

final class LoginService {
    static let loginService = LoginService()
    let db = Firestore.firestore()
    
    func signUpUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
                return
            }
            if let email = authResult?.user.email {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "email": email
                ]) { error in
                    if let error = error {
                        print("사용자 데이터 Firestore에 저장 실패: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
