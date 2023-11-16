//
//  MyCarPageView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class MyCarPageView: UIView {
    // MARK: Properties
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var myCarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .backgroundCoustomColor
        view.clipsToBounds = true
        view.register(MyCarCollectionViewCell.self, forCellWithReuseIdentifier: MyCarCollectionViewCell.identifier)
        return view
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
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
        addSubview(myCarCollectionView)
        
        myCarCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
