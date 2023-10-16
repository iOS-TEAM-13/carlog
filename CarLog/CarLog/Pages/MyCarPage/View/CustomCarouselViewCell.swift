//
//  CustomCarouselViewCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/13.
//

import SnapKit
import UIKit

class CustomCarouselView: UIView {
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let checkTitle: UILabel = {
        let label = UILabel()
        label.customLabel(text: "타이틀", textColor: .primaryColor, font: Constants.fontJua36 ?? UIFont.systemFont(ofSize: 36), alignment: .center)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let calendarView = CalendarView()
    
    static let identifier = "CustomCarouselViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(customView)
        customView.addSubview(checkTitle)
        customView.addSubview(calendarView)
        
        customView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        checkTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(checkTitle.snp.bottom).inset(Constants.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.horizontalMargin)
        }
    }
    
    func bind(title: String) {
        checkTitle.text = title
    }
}
