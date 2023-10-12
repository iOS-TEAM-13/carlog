//
//  CarouselView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class CarouselView: UIView {
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 600)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CarouselViewCell.self, forCellWithReuseIdentifier: CarouselViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.decelerationRate = .fast
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = UIEdgeInsets(top: 0, left: (UIScreen.main.bounds.width - 300) / 2, bottom: 0, right: (UIScreen.main.bounds.width - 300) / 2)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
