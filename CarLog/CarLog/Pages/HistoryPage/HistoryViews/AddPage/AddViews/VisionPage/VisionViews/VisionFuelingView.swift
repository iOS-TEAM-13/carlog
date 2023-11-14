//
//  VisionFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit

class VisionFuelingView: UIView {
    
    lazy var visionFuelingStackView: UIStackView = {
        let visionFuelingStackView = UIStackView(arrangedSubviews: [visionInfoLabel, visionReceiptStackView])
        visionFuelingStackView.customStackView(spacing: 20, axis: .vertical, alignment: .center)
        visionFuelingStackView.backgroundColor = .white
        visionFuelingStackView.layer.cornerRadius = Constants.cornerRadius
        return visionFuelingStackView
    }()
    
    //안내 라벨
    lazy var visionInfoLabel: UILabel = {
        let visionInfoLabel = UILabel()
        visionInfoLabel.customLabel(text: "영수증 사진을 선택해주세요.", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return visionInfoLabel
    }()
    
    //MARK: - 영수증 선택 스택뷰
    lazy var visionReceiptStackView: UIStackView = {
        let visionReceiptStackView = UIStackView(arrangedSubviews: [receiptLabel, visionReceiptImageButton, visionReceiptTextFieldStackView, visionReceiptImageView])
        visionReceiptStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .center)
        return visionReceiptStackView
    }()
    
    lazy var receiptLabel: UILabel = {
        let receiptLabel = UILabel()
        receiptLabel.customLabel(text: "영수증", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return receiptLabel
    }()
    
    //영수증 이미지 선택 버튼
    lazy var visionReceiptImageButton: UIButton = {
        let visionReceiptImageButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        visionReceiptImageButton.configuration = config
        return visionReceiptImageButton
    }()
    
    //영수증 등록 시 하단에 노출되는 텍스트필드 스택뷰
    lazy var visionReceiptTextFieldStackView: UIStackView = {
        let visionReceiptTextFieldStackView = UIStackView(arrangedSubviews: [visionPriceStackView, visionCountStackView, visionTotalPriceStackView])
        visionReceiptTextFieldStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        visionReceiptTextFieldStackView.distribution = .fillEqually
        return visionReceiptTextFieldStackView
    }()
    
    //단가 스택뷰 (단가, 단가 텍스트필드)
    lazy var visionPriceStackView: UIStackView = {
        let visionPriceStackView = UIStackView(arrangedSubviews: [priceLabel, visionPriceTextField])
        visionPriceStackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return visionPriceStackView
    }()
    
    //단가
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.customLabel(text: "단가", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return priceLabel
    }()
    
    //단가 텍스트필드
    lazy var visionPriceTextField: UITextField = {
        let visionPriceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        visionPriceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 1777", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionPriceTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionPriceTextField
    }()
    
    //수량 스택뷰 (수량, 수량 텍스트필드)
    lazy var visionCountStackView: UIStackView = {
        let visionCountStackView = UIStackView(arrangedSubviews: [countLabel, visionCountTextField])
        visionCountStackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return visionCountStackView
    }()
    
    //수량
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.customLabel(text: "수량", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return countLabel
    }()
    
    //수량 텍스트필드
    lazy var visionCountTextField: UITextField = {
        let visionCountTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        visionCountTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 55.555/55", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionCountTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionCountTextField
    }()
    
    //금액 스택뷰 (금액, 금액 텍스트필드)
    lazy var visionTotalPriceStackView: UIStackView = {
        let visionTotalPriceStackView = UIStackView(arrangedSubviews: [totalPriceLabel, visionTotalPriceTextField])
        visionTotalPriceStackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return visionTotalPriceStackView
    }()
    
    //금액
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.customLabel(text: "금액", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return totalPriceLabel
    }()
    
    //금액 텍스트필드
    lazy var visionTotalPriceTextField: UITextField = {
        let visionTotalPriceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        visionTotalPriceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 100000", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionTotalPriceTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionTotalPriceTextField
    }()
    
    //영수증 이미지뷰
    lazy var visionReceiptImageView: UIImageView = {
        let visionReceiptImageView = UIImageView()
        visionReceiptImageView.contentMode = .scaleAspectFit
        return visionReceiptImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - visionFuelingView UI 설정
    private func setupUI() {
        addSubview(visionFuelingStackView)

        visionFuelingStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
        }
        
        visionInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(visionFuelingStackView).offset(20)
        }
        
        visionReceiptTextFieldStackView.snp.makeConstraints { make in
            make.leading.equalTo(visionFuelingStackView).offset(70)
            make.trailing.equalTo(visionFuelingStackView).offset(-70)
        }
        
        visionPriceTextField.snp.makeConstraints { make in
            make.leading.equalTo(visionCountTextField)
        }
        
        visionTotalPriceTextField.snp.makeConstraints { make in
            make.leading.equalTo(visionCountTextField)
            make.bottom.equalTo(visionFuelingStackView.snp.bottom).offset(-20)
        }
        
        visionReceiptImageButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
}
