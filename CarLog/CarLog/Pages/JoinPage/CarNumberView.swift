import UIKit

import SnapKit

final class CarNumberView: UIView {
    let duplicateComponents = DuplicateComponents()
    
    lazy var label: UILabel = duplicateComponents.joinupLabel(text: "차량번호를\n입력해주세요")
    lazy var carNumberTextField: UITextField = duplicateComponents.joinupTextField(placeholder: "차량번호 ex)56머3344")
    lazy var popButton: UIButton = duplicateComponents.joininButton(text: "이 전")
    lazy var nextButton: UIButton = duplicateComponents.joininButton(text: "다 음")
    lazy var spaceView = UIView()
    lazy var buttonStackView: UIStackView = duplicateComponents.buttonStackView(list: [popButton, spaceView, nextButton])
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(carNumberTextField)
        addSubview(buttonStackView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(carNumberTextField.snp.top).offset(-150)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        carNumberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(carNumberTextField.snp.bottom).offset(75)
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
