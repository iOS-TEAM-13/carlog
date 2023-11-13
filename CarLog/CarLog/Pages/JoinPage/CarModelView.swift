import UIKit

import SnapKit

final class CarModelView: UIView {
    let duplicateComponents = DuplicateComponents()
    
    lazy var label: UILabel = duplicateComponents.joinupLabel(text: "차량명을\n입력해주세요")
    lazy var carModelTextField: UITextField = duplicateComponents.joinupTextField(placeholder: "차종 입력", keyboardType: .default)
    lazy var nextButton = largeButton(text: "다 음", titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(carModelTextField)
        addSubview(nextButton)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(carModelTextField.snp.top).offset(-150)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        carModelTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(carModelTextField.snp.bottom).offset(75)
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
