//
//  VisionDrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit

class VisionDrivingView: UIView {

    lazy var visionStackView: UIStackView = {
        let visionStackView = UIStackView(arrangedSubviews: [visionInfoLabel, visionButtonTextFieldStackView])
        visionStackView.customStackView(spacing: 20, axis: .vertical, alignment: .center)
        visionStackView.backgroundColor = .white
        visionStackView.layer.cornerRadius = Constants.cornerRadius
        return visionStackView
    }()
    
    //안내 라벨
    lazy var visionInfoLabel: UILabel = {
        let visionInfoLabel = UILabel()
        visionInfoLabel.customLabel(text: "출발, 도착 주행거리를 선택해주세요.", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return visionInfoLabel
    }()
    
    //MARK: - 버튼, 텍스트필드 스택뷰
    lazy var visionButtonTextFieldStackView: UIStackView = {
        let visionButtonTextFieldStackView = UIStackView(arrangedSubviews: [visionDepartDistanceStackView, visionArriveDistanceStackView])
        visionButtonTextFieldStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .center)
        return visionButtonTextFieldStackView
    }()
    
    //MARK: - 왼쪽 출발 버튼, 텍스트필드 스택뷰
    lazy var visionDepartDistanceStackView: UIStackView = {
        let visionDepartDistanceStackView = UIStackView(arrangedSubviews: [departLabel, visionDepartImageButton, visionDepartTextField])
        visionDepartDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .center)
        return visionDepartDistanceStackView
    }()
    
    lazy var departLabel: UILabel = {
        let departLabel = UILabel()
        departLabel.customLabel(text: "출발", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return departLabel
    }()
    
    lazy var visionDepartImageButton: UIButton = {
        let visionDepartImageButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        visionDepartImageButton.configuration = config
        return visionDepartImageButton
    }()
    
    lazy var visionDepartTextField: UITextField = {
        let visionDepartTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        visionDepartTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10000", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionDepartTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionDepartTextField
    }()
    
    lazy var visionDepartImageView: UIImageView = {
        let visionDepartImageView = UIImageView()
        visionDepartImageView.contentMode = .scaleAspectFill
        return visionDepartImageView
    }()
    
    //MARK: - 오른쪽 도착 버튼, 텍스트필드 스택뷰
    lazy var visionArriveDistanceStackView: UIStackView = {
        let visionArriveDistanceStackView = UIStackView(arrangedSubviews: [arriveLabel, visionArriveImabeButton, visionArriveTextField])
        visionArriveDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .center)
        return visionArriveDistanceStackView
    }()
    
    lazy var arriveLabel: UILabel = {
        let arriveLabel = UILabel()
        arriveLabel.customLabel(text: "도착", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return arriveLabel
    }()
    
    lazy var visionArriveImabeButton: UIButton = {
        let visionArriveImabeButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        visionArriveImabeButton.configuration = config
        return visionArriveImabeButton
    }()
    
    lazy var visionArriveTextField: UITextField = {
        let visionArriveTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        visionArriveTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10020", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionArriveTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionArriveTextField
    }()
    
    lazy var arriveImageView: UIImageView = {
        let arriveImageView = UIImageView()
        arriveImageView.contentMode = .scaleAspectFill
        return arriveImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addVisionFueling UI 설정
    private func setupUI() {
        addSubview(visionStackView)

        visionStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
        }
        
        visionInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(visionStackView).offset(20)
        }
        
        visionArriveTextField.snp.makeConstraints { make in
            make.bottom.equalTo(visionStackView.snp.bottom).offset(-20)
        }
        
        visionDepartImageButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }

        visionArriveImabeButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
    
}
