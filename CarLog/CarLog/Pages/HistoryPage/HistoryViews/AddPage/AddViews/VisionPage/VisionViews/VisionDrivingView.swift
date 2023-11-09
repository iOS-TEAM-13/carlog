//
//  VisionDrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit

class VisionDrivingView: UIView {

    lazy var addvisionStackView: UIStackView = {
        let visionStackView = UIStackView(arrangedSubviews: [addVisionLabel, addVisionButtonStackView])
        visionStackView.customStackView(spacing: 30, axis: .vertical, alignment: .center)
        visionStackView.backgroundColor = .white
        visionStackView.layer.cornerRadius = Constants.cornerRadius
        return visionStackView
    }()
    
    lazy var addVisionLabel: UILabel = {
        let addVisionLabel = UILabel()
        addVisionLabel.customLabel(text: "출발, 도착 주행거리를 선택해주세요.", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return addVisionLabel
    }()
    
    lazy var addVisionButtonStackView: UIStackView = {
        let addVisionButtonStackView = UIStackView(arrangedSubviews: [addDepartVisionStackView, addArriveVisionStackView])
        addVisionButtonStackView.customStackView(spacing: 20, axis: .horizontal, alignment: .center)
        addVisionButtonStackView.backgroundColor = .red
        return addVisionButtonStackView
    }()
    
    lazy var addDepartVisionStackView: UIStackView = {
        let addDepartVisionStackView = UIStackView(arrangedSubviews: [addDepartVisionButton, departTextField, departImageView ])
        addDepartVisionStackView.customStackView(spacing: 30, axis: .vertical, alignment: .center)
        addDepartVisionStackView.backgroundColor = .yellow
        return addDepartVisionStackView
    }()
    
    lazy var addDepartVisionButton: UIButton = {
        let addDepartVisionButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        addDepartVisionButton.configuration = config
        return addDepartVisionButton
    }()
    
    lazy var departImageView: UIImageView = {
        let departImageView = UIImageView()
        departImageView.contentMode = .scaleAspectFill
        return departImageView
    }()
    
    lazy var departTextField: UITextField = {
        let departTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        departTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 드라이브, 출퇴근", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: departTextField.frame.size.height)), keyboardType: .decimalPad)
        
//        let nextTextField = UIToolbar()
//        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
//        nextTextField.barStyle = UIBarStyle.default
//        nextTextField.isTranslucent = true
//        nextTextField.sizeToFit()
//        
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeDrivingPurposeTextField))
//        
//        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
//        nextTextField.isUserInteractionEnabled = true
//        departTextField.inputAccessoryView = nextTextField
        
        return departTextField
    }()
    
    lazy var addArriveVisionStackView: UIStackView = {
        let addArriveVisionStackView = UIStackView(arrangedSubviews: [addArriveVisionButton, arriveImageView])
        addArriveVisionStackView.customStackView(spacing: 30, axis: .vertical, alignment: .center)
        return addArriveVisionStackView
    }()
    
    lazy var addArriveVisionButton: UIButton = {
        let addArriveVisionButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        addArriveVisionButton.configuration = config
        return addArriveVisionButton
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
        addSubview(addvisionStackView)
        
        addvisionStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        addDepartVisionButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        departImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        addArriveVisionButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        arriveImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
    
    //
    func setDepartImage(image: UIImage) {
        let resizedImage = image.resize(to: CGSize(width: 150, height: 150))
        addDepartVisionButton.setImage(resizedImage, for: .normal)
        departImageView.image = resizedImage
    }

    func setArriveImage(image: UIImage) {
        let resizedImage = image.resize(to: CGSize(width: 150, height: 150))
        addArriveVisionButton.setImage(resizedImage, for: .normal)
        arriveImageView.image = resizedImage
    }
}

//
extension UIImage {
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
