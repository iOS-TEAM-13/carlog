import UIKit

import SnapKit

class NickNameView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.customLabel(text: "차량 별명(닉네임)을\n입력해주세요", textColor: .white, font: Constants.fontJua36 ?? UIFont(), alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var carNickNameTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "차 별명 입력", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "이 전", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var spaceView = UIView()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popButton, spaceView, nextButton])
        stackView.customStackView(spacing: 40, axis: .horizontal, alignment: .fill)
        return stackView
    }()
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(carNickNameTextField)
        addSubview(buttonStackView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.top).offset(-100)
            make.leading.equalTo(safeArea.snp.leading).offset(20)
        }

        carNickNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(20)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.bottom).offset(50)
            make.centerX.equalTo(safeArea.snp.centerX)
            make.leading.equalTo(safeArea.snp.leading).offset(20)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
