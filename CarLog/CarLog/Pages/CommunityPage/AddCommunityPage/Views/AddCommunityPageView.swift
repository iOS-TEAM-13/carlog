//
//  AddCommunityPageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 11/14/23.
//

import UIKit

class AddCommunityPageView: UIView {
    
    // MARK: - Properties
    
    lazy var imagePickerView: UIImageView = {
        let imagePickerView = UIImageView()
        imagePickerView.backgroundColor = .white
        imagePickerView.clipsToBounds = true // 사진 cornerRadius 적용되게
        imagePickerView.layer.cornerRadius = 5
        return imagePickerView
    }()
    
    lazy var secondImageView: UIImageView = {
        let secondImageView = UIImageView()
        secondImageView.clipsToBounds = true
        secondImageView.layer.cornerRadius = 5
        return secondImageView
    }()
    
    lazy var thirdImageView: UIImageView = {
        let thirdImageView = UIImageView()
        thirdImageView.clipsToBounds = true
        thirdImageView.layer.cornerRadius = 5
        return thirdImageView
    }()
    
    lazy var imagePickerButton: UIButton = {
        let imagePickerButton = UIButton()
        imagePickerButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal) // 플러스 버튼의 속성을 설정
        imagePickerButton.tintColor = .buttonSkyBlueColor // 아이콘 색상 설정
        return imagePickerButton
    }()
    
    lazy var numberOfSelectedImageLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .mainNavyColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 12.0
        return label
    }()
    
    lazy var mainTextField: UITextField = {
        let mainTextField = UITextField()
        mainTextField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ])
        mainTextField.textColor = .black
        mainTextField.backgroundColor = .white
        mainTextField.layer.borderColor = UIColor.clear.cgColor
        mainTextField.layer.borderWidth = 0
        mainTextField.layer.cornerRadius = 5
        mainTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mainTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: mainTextField.frame.size.height))
        mainTextField.leftViewMode = .always
        mainTextField.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium)
        return mainTextField
    }()
    
    lazy var subTextViewPlaceHolder = "택스트를 입력하세요"
    lazy var subTextView: UITextView = {
        let subTextView = UITextView()
        subTextView.textColor = .black
        subTextView.backgroundColor = .white
        subTextView.layer.borderColor = UIColor.clear.cgColor
        subTextView.layer.borderWidth = 0
        subTextView.layer.cornerRadius = Constants.cornerRadius
        subTextView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        subTextView.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium)
//        subTextView.delegate = self
        return subTextView
    }()
    
    lazy var imagePickerStackView: UIStackView = {
        let imagePickerStackView = UIStackView()
        imagePickerStackView.axis = .horizontal
        imagePickerStackView.spacing = 16
        imagePickerStackView.distribution = .fill
        return imagePickerStackView
    }()
    
    // MARK: - Inirializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    func setupUI() {
        [
            mainTextField,
            subTextView,
            imagePickerView,
            imagePickerStackView,
            imagePickerButton,
            numberOfSelectedImageLabel
        ].forEach { self.addSubview($0) }

        mainTextField.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constants.horizontalMargin)
            make.leading.equalTo(self.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        subTextView.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(self.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(400)
        }
        
        imagePickerView.snp.makeConstraints { make in
            make.top.equalTo(subTextView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin)
            make.size.equalTo(90)
        }
        
        imagePickerStackView.snp.makeConstraints { make in
            make.top.equalTo(subTextView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(imagePickerView.snp.trailing).inset(-Constants.horizontalMargin)
            make.height.equalTo(90)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.width.height.equalTo(90)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.width.height.equalTo(90)
        }
        
        imagePickerButton.snp.makeConstraints { make in
            make.center.size.equalTo(imagePickerView)
        }
        
        numberOfSelectedImageLabel.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.trailing.equalTo(imagePickerView).inset(-Constants.horizontalMargin * 0.5)
        }
    }
}
