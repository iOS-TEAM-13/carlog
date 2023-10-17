import UIKit

import SnapKit

class OilModelView: UIView {
    let duplicateComponents = DuplicateComponents()
    let oilOptions: [String] = ["휘발유", "경유", "LPG", "전기"]
    private var selectedOil: String?

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
            make.height.equalTo(50)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(oilPickerView.snp.bottom).offset(50)
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
        return 1 // 1개의 컴포넌트
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 여기에서 주종 항목의 개수를 반환합니다.
        return oilOptions.count // oilOptions는 주종 목록 배열로 대체해야 합니다.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 여기에서 주종 항목의 각 행의 제목을 설정합니다.
        return oilOptions[row] // oilOptions는 주종 목록 배열로 대체해야 합니다.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 사용자가 선택한 주종을 업데이트합니다.
        selectedOil = oilOptions[row] // oilOptions는 주종 목록 배열로 대체해야 합니다.
    }
}
