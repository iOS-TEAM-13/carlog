import UIKit

import SnapKit

class JoinupPageViewController: UIViewController {
    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        setupUI()
    }

    func setupUI() {
        view.addSubview(joinupView)
        
        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        joinupView.joinInButton.addTarget(self, action: #selector(joinInButtonTapped), for: .touchUpInside)
        joinupView.showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        joinupView.showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
    }
    
    @objc func joinInButtonTapped(){
        joinupView.isHidden = true
        view.addSubview(carNumberView)
        carNumberView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        carNumberView.isHidden = false
    }

    @objc func togglePasswordVisibilityTapped() {
        toggleVisibility(button: joinupView.showPasswordButton, textField: joinupView.passwordTextField)
    }

    @objc func toggleConfirmVisibilityTapped() {
        toggleVisibility(button: joinupView.showConfirmPasswordButton, textField: joinupView.confirmPasswordTextField)
    }
    
    private func toggleVisibility(button: UIButton, textField: UITextField){
        let imageName = joinupView.isSecure ? "invisible" : "eye"
        button.setImage(UIImage(named: imageName), for: .normal)
        joinupView.isSecure.toggle()
        textField.isSecureTextEntry = joinupView.isSecure
    }
}
