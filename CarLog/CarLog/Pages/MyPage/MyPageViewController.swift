import FirebaseAuth
import SnapKit
import UIKit

class MyPageViewController: UIViewController {
    let myPageView = MyPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(myPageView)
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addTargetButton()
    }

    func addTargetButton() {
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    @objc func logoutButtonTapped() {
        if Auth.auth().currentUser != nil {
            LoginService.loginService.logout {
                let loginViewController = LoginPageViewController()
                self.dismiss(animated: true) {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate
                    {
                        sceneDelegate.window?.rootViewController = loginViewController
                    }
                }
            }
        } else {
            dismiss(animated: true)
        }
    }
}
