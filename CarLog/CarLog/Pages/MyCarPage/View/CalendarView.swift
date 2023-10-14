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
        let view = UIStackView(arrangedSubviews: [firstStackView, secondStackView, thirdStackView])
        view.customStackView(spacing: 10, axis: .vertical, alignment: .fill)
        view.distribution = .fillEqually
//        view.backgroundColor = .thirdColor
//        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy private var firstStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [january, february, march, april])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var secondStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [may, june, july, august])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    lazy private var thirdStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [september, october, november, december])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    private let spacingView = UIView()
    
    private let january: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Jan", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let february: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Feb", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let march: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Mar", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let april: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Apr", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let may: UILabel = {
        let label = UILabel()
        label.customLabel(text: "May", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let june: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Jun", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let july: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Jul", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let august: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Aug", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let september: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Sep", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let october: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Oct", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let november: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Nov", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let december: UILabel = {
        let label = UILabel()
        label.customLabel(text: "Dec", textColor: .primaryColor, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .center)
        label.backgroundColor = .thirdColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(totalStackView)
        self.addSubview(spacingView)
        
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        spacingView.snp.makeConstraints {
            $0.top.equalTo(totalStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}
