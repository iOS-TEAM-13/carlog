import UIKit

import SnapKit

class TotalDistanceView: UIView {
    let duplicateComponents = DuplicateComponents()
    
    lazy var label = duplicateComponents.joinupLabel(text: "최종 주행거리는\n얼마인가요?")
    lazy var totalDistanceTextField = duplicateComponents.joinupTextField(placeholder: "최종 주행거리 입력")
    lazy var popButton: UIButton = duplicateComponents.joininButton(text: "이 전")
    lazy var nextButton: UIButton = duplicateComponents.joininButton(text: "완 료")
    lazy var spaceView = UIView()
    lazy var buttonStackView: UIStackView = duplicateComponents.buttonStackView(list: [popButton, spaceView, nextButton])
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(label)
        addSubview(totalDistanceTextField)
        addSubview(buttonStackView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(totalDistanceTextField.snp.top).offset(-100)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        totalDistanceTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(totalDistanceTextField.snp.bottom).offset(50)
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
