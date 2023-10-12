import UIKit

import SnapKit

class JoinupPageViewController: UIViewController {
    let joinInproperties = JoinupPageProperties()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        setupUI()
    }

    func setupUI() {
        view.addSubview(joinInproperties)
        joinInproperties.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        joinInproperties.showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        joinInproperties.showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibility), for: .touchUpInside)
    }

    @objc func togglePasswordVisibility() {
        // 버튼 이미지를 토글
        let imageName = joinInproperties.isSecure ? "eye.fill" : "eye"
        joinInproperties.showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)

        // 비밀번호 필드의 가시성을 업데이트
        joinInproperties.isSecure.toggle()
        joinInproperties.passwordTextField.isSecureTextEntry = joinInproperties.isSecure
    }

    @objc func toggleConfirmVisibility() {
        // 버튼 이미지를 토글
        let imageName = joinInproperties.isSecure ? "eye.fill" : "eye"
        joinInproperties.showConfirmPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)

        // 비밀번호 확인 필드의 가시성을 업데이트
        joinInproperties.isSecure.toggle()
        joinInproperties.confirmPasswordTextField.isSecureTextEntry = joinInproperties.isSecure
    }
}
