import UIKit
import SnapKit

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
    LoginService.loginService.logout {
        self.dismiss(animated: true)
    }
 }
    
}
