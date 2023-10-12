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
        joinInproperties.joinInButton.addTarget(self, action: #selector(joinInButtonTapped), for: .touchUpInside)
        joinInproperties.showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        joinInproperties.showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
    }
    
    @objc func joinInButtonTapped(){
        
    }

    @objc func togglePasswordVisibilityTapped() {
        let imageName = joinInproperties.isSecure ? "invisible" : "eye"
        joinInproperties.showPasswordButton.setImage(UIImage(named: imageName), for: .normal)

        joinInproperties.isSecure.toggle()
        joinInproperties.passwordTextField.isSecureTextEntry = joinInproperties.isSecure
    }

    @objc func toggleConfirmVisibilityTapped() {
        let imageName = joinInproperties.isSecure ? "invisible" : "eye"
        joinInproperties.showConfirmPasswordButton.setImage(UIImage(named: imageName), for: .normal)

        joinInproperties.isSecure.toggle()
        joinInproperties.confirmPasswordTextField.isSecureTextEntry = joinInproperties.isSecure
    }
}
