import Firebase
import UIKit

class CommunityPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // 로그아웃 버튼 생성
        let logoutButton = UIButton()
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.layer.cornerRadius = 10
        logoutButton.addTarget(self, action: #selector(self.logoutButtonTapped), for: .touchUpInside)

        // 버튼을 뷰 중앙에 추가
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func logoutButtonTapped() {
        if let email = Auth.auth().currentUser?.email {
            LoginService.loginService.quitUser(email: email) { error in
                if error == nil {
                    self.dismiss(animated: true)
                } else {
                    print("회원탈퇴 실패 또는 오류: \(error?.localizedDescription ?? "알 수 없는 오류")")
                }
            }
        }
    }
}
