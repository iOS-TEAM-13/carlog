//
//  FuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class FuelingView: UIView {
    
    var dummy = [
        Fueling(timeStamp: "2023.10.15", totalDistance: 17777, price: 1777, count: 55, totalPrice: 89999),
        Fueling(timeStamp: "2020.10.12", totalDistance: 17787, price: 1776, count: 56, totalPrice: 100000),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
    ]
    
    lazy var fuelingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let fuelingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        fuelingCollectionView.dataSource = self
        fuelingCollectionView.delegate = self
        fuelingCollectionView.register(FuelingCollectionViewCell.self, forCellWithReuseIdentifier: FuelingCollectionViewCell.identifier)        
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

extension FuelingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuelingCollectionViewCell.identifier, for: indexPath) as! FuelingCollectionViewCell
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = Constants.cornerRadius
        
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        
        cell.writeDateLabel.text = dummy[indexPath.row].timeStamp
        cell.priceLabel.text = String("\(dummy[indexPath.row].price)원")
        cell.totalPriceLabel.text = String("\(dummy[indexPath.row].totalPrice)원")
        cell.countLabel.text = String("\(dummy[indexPath.row].count)L")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - Constants.horizontalMargin * 4), height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
