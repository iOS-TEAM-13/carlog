//
//  CustomMapView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/02.
//

import UIKit

import MapKit
import SnapKit

class CustomMapView: UIView {
    var searchButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("현 위치에서 검색", for: .normal)
        btn.backgroundColor = .mainNavyColor
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = Constants.cornerRadius
        return btn
    }()
    
    let map = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(map)
        addSubview(searchButton)
        
        configureUI()
        makeConstraintUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {}
    
    private func makeConstraintUI() {
        map.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Constants.verticalMargin * 2)
            $0.centerX.equalTo(self)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
}
