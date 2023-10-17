import UIKit

import SnapKit

class NickNameView: UIView {
    let duplicateComponents = DuplicateComponents()
    
    lazy var label: UILabel = duplicateComponents.joinupLabel(text: "차량 별명(닉네임)을\n입력해주세요")
    lazy var carNickNameTextField: UITextField = duplicateComponents.joinupTextField(placeholder: "차 별명 입력")
    lazy var popButton: UIButton = duplicateComponents.joininButton(text: "이 전")
    lazy var nextButton: UIButton = duplicateComponents.joininButton(text: "다 음")
    lazy var spaceView = UIView()
    lazy var buttonStackView: UIStackView = duplicateComponents.buttonStackView(list: [popButton, spaceView, nextButton])
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(carNickNameTextField)
        addSubview(buttonStackView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.top).offset(-100)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        carNickNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        buttonStackView.snp.makeConstraints { make in
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
