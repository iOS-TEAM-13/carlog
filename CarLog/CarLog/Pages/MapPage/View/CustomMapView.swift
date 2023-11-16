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
    // MARK: Properties
    lazy var map = MKMapView()
    
    lazy var searchButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("현 위치에서 검색", for: .normal)
        btn.backgroundColor = .mainNavyColor
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = Constants.cornerRadius
        return btn
    }()
    
    lazy var myLocationButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "currentLocate"), for: .normal)
        return btn
    }()
    
    lazy var zoomInButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "zoomin"), for: .normal)
        return btn
    }()
    
    lazy var zoomOutButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "zoomout"), for: .normal)
        return btn
    }()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    private func setupUI() {
        addSubview(map)
        addSubview(searchButton)
        addSubview(myLocationButton)
        addSubview(zoomInButton)
        addSubview(zoomOutButton)
        
        map.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        zoomOutButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(myLocationButton.snp.top).inset(-10)
        }
        
        zoomInButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(zoomOutButton.snp.top).inset(-10)
        }
        
        searchButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Constants.verticalMargin * 2)
            $0.centerX.equalTo(self)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
}
