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
        joinInproperties.isHidden = true
    }

    @objc func togglePasswordVisibilityTapped() {
        toggleVisibility(button: joinInproperties.showPasswordButton, textField: joinInproperties.passwordTextField)
    }

    @objc func toggleConfirmVisibilityTapped() {
        toggleVisibility(button: joinInproperties.showConfirmPasswordButton, textField: joinInproperties.confirmPasswordTextField)
    }
    
    private func toggleVisibility(button: UIButton, textField: UITextField){
        let imageName = joinInproperties.isSecure ? "invisible" : "eye"
        button.setImage(UIImage(named: imageName), for: .normal)
        joinInproperties.isSecure.toggle()
        textField.isSecureTextEntry = joinInproperties.isSecure
    }
}
