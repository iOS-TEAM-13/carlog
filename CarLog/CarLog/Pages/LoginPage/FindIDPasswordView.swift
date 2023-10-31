//
//  FindIDPasswordView.swift
//  CarLog
//
//  Created by 김은경 on 10/31/23.
//

import UIKit

import SnapKit

class FindIDPasswordView: UIView {

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["아이디 찾기", "비밀번호 재설정"])
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.selectedSegmentTintColor = .mainNavyColor

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "이메일 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    //lazy var findButton:
    
    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "취 소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold), titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
        return button
    }()

    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = shouldHideFirstView else { return }
//            self.drivingCollectionView.isHidden = shouldHideFirstView
//            self.fuelingCollectionView.isHidden = !self.drivingCollectionView.isHidden
        }
    }
}
