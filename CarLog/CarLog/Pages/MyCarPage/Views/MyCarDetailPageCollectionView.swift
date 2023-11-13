//
//  MyCarDetailPageCollectionView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class MyCarDetailPageCollectionView: UIView {
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var detailCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .backgroundCoustomColor
        view.clipsToBounds = true
        view.register(MyCarDetialViewCell.self, forCellWithReuseIdentifier: MyCarDetialViewCell.identifier)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(detailCollectionView)
        
        detailCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}
