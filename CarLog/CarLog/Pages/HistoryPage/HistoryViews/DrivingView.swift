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
    }
    
}
