import UIKit

import SnapKit

final class NickNameView: UIView {
    let duplicateComponents = DuplicateComponents()
    
    lazy var label: UILabel = duplicateComponents.joinupLabel(text: "차량 별명(닉네임)을\n입력해주세요")

    lazy var carNickNameTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(
            placeholder: "차 별명 입력",
            textColor: .black,
            font: .spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
            alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height))
            )
        textField.rightView = checkNickNameButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var checkNickNameButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium), titleColor: .black, backgroundColor: .clear)
        return button
    }()

    lazy var nextButton: UIButton = duplicateComponents.joininButton(text: "다 음")
   
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(carNickNameTextField)
        addSubview(nextButton)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.top).offset(-150)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        carNickNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.bottom).offset(75)
            make.centerX.equalTo(safeArea.snp.centerX)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
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
