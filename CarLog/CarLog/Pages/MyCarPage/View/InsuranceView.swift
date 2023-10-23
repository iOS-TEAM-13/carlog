//
//  CustomCarouselViewCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/13.
//

import SnapKit
import UIKit

class InsuranceView: UIView {
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let checkTitleLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "타이틀", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua36, weight: .medium), alignment: .center)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let calendarView = CalendarView()
    
    static let identifier = "CustomCarouselViewCell"
    
    init(view: CheckingView) {
        super.init(frame: .zero)
        setupUI()
        configureUI(view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(customView)
        customView.addSubview(checkTitleLabel)
        customView.addSubview(calendarView)
        
        customView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        checkTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(customView).inset(Constants.horizontalMargin)
            $0.height.equalTo(100)
        }
        
        calendarView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.width.equalTo(300)
            $0.center.equalToSuperview()
        }
    }
    
    private func configureUI(view: CheckingView) {
        self.checkTitleLabel.text = view.title
    }
    
    func bind(title: String) {
        checkTitleLabel.text = title
    }
}
