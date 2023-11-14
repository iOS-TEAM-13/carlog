//
//  FindIDPasswordView.swift
//  CarLog
//
//  Created by 김은경 on 10/31/23.
//

import SnapKit
import UIKit

class FindIDPasswordView: UIView {
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재설정"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .mainNavyColor
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["아이디 찾기", "비밀번호 재설정"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .mainNavyColor

        segmentedControl.setTitleTextAttributes([.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()

    lazy var findIDView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .red
        return uiView
    }()

    lazy var reSettingPasswordView: UIView = {
        let uiView = UIView()
        uiView.isHidden = true
        return uiView
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "이메일 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var buttonStackView = LargeButtonStackView(firstButtonText: "전 송", firstTitleColor: .buttonSkyBlueColor, firstBackgroudColor: .mainNavyColor, secondButtonText: "취 소")

    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = shouldHideFirstView else { return }
            findIDView.isHidden = shouldHideFirstView
            reSettingPasswordView.isHidden = !shouldHideFirstView
        }
    }
}
