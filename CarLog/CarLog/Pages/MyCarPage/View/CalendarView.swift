//
//  CalendarView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/13.
//

import UIKit
import SnapKit

class CalendarView: UIView {
    private let calendarView = UIView()
    
    lazy private var totalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstStackView, secondStackView, thirdStackView, fourthStackView])
        view.customStackView(spacing: 10, axis: .vertical, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var firstStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [january, february, march])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var secondStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [april, may, june])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var thirdStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [july, august, september, ])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var fourthStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [october, november, december])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var january = self.customButton(text: "Jan")
    lazy var february = self.customButton(text: "Feb")
    lazy var march = self.customButton(text: "Mar")
    lazy var april = self.customButton(text: "Apr")
    lazy var may = self.customButton(text: "May")
    lazy var june = self.customButton(text: "Jun")
    lazy var july = self.customButton(text: "Jul")
    lazy var august = self.customButton(text: "Aug")
    lazy var september = self.customButton(text: "Sep")
    lazy var october = self.customButton(text: "Oct")
    lazy var november = self.customButton(text: "Nov")
    lazy var december = self.customButton(text: "Dec")
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(totalStackView)
        
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func customButton(text: String) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
        button.backgroundColor = .buttonSkyBlueColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 4
        return button
    }
}
