//
//  DrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class DrivingView: UIView {
    
    var navigationController: UINavigationController?
    
    lazy var drivingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let drivingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return drivingCollectionView
    }()
    
    lazy var noDataLabel: UILabel = {
        let noDataLabel = UILabel()
        noDataLabel.customLabel(text: "주행기록을 추가하여\n차량 관리를 시작하세요!", textColor: .gray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), alignment: .center)
        noDataLabel.numberOfLines = 2
        return noDataLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(drivingCollectionView)
        drivingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
