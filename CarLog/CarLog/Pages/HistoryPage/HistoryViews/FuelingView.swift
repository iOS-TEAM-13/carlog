//
//  FuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class FuelingView: UIView {
    
    var navigationController: UINavigationController?
    
    lazy var fuelingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let fuelingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return fuelingCollectionView
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
    }
    
}
