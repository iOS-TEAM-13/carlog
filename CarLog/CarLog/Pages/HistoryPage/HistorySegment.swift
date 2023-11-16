//
//  HistorySegment.swift
//  CarLog
//
//  Created by 김지훈 on 11/15/23.
//

import UIKit
import SnapKit

class HistorySegment: UIView {

    //히스토리 페이지 상단 주행, 주유 collectionView 나눠서 보여지게하는 segmented
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .mainNavyColor
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .bold), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .bold), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addDrivingView UI 설정
    private func setupUI() {
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
