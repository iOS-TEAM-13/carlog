import UIKit

import SnapKit

final class OilModelView: UIView {
    let duplicateComponents = DuplicateComponents()
    let oilOptions: [String] = ["선택", "휘발유", "경유"]
    var selectedOil: String?

    lazy var label = duplicateComponents.joinupLabel(text: "주종을\n선택해주세요")
    lazy var oilPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    lazy var popButton: UIButton = duplicateComponents.joininButton(text: "이 전")
    lazy var nextButton: UIButton = duplicateComponents.joininButton(text: "다 음")
    lazy var spaceView = UIView()
    lazy var buttonStackView: UIStackView = duplicateComponents.buttonStackView(list: [popButton, spaceView, nextButton])

    private func setupUI() {
        let safeArea = safeAreaLayoutGuide

        addSubview(label)
        addSubview(oilPickerView)
        addSubview(buttonStackView)

        label.snp.makeConstraints { make in
            make.top.equalTo(oilPickerView.snp.top).offset(-100)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        oilPickerView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(150)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(oilPickerView.snp.bottom).offset(25)
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

extension OilModelView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return oilOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return oilOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOil = oilOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
}
