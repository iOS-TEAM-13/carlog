//
//  FuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import UIKit
import SnapKit

class FuelingView: UIView {
    var navigationController: UINavigationController?
    
    lazy var fuelingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let fuelingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return fuelingCollectionView
    }()
    
    lazy var noDataLabel: UILabel = {
        let noDataLabel = UILabel()
        noDataLabel.customLabel(text: "주유기록을 추가하여\n차량 관리를 시작하세요!", textColor: .gray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), alignment: .center)
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
        addSubview(fuelingCollectionView)
        fuelingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
