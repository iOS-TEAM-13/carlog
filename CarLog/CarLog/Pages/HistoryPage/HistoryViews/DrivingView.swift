//
//  DrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class DrivingView: UIView {
    
    var dummy = [
        Driving(timeStamp: "2023.10.15", departDistance: 17777, arriveDistance: 17778, driveDistance: 1),
        Driving(timeStamp: "2023.10.15", departDistance: 17778, arriveDistance: 17788, driveDistance: 10),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
    ]
    
    lazy var drivingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let drivingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        drivingCollectionView.dataSource = self
        drivingCollectionView.delegate = self
        drivingCollectionView.register(DrivingCollectionViewCell.self, forCellWithReuseIdentifier: DrivingCollectionViewCell.identifier)
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

extension DrivingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrivingCollectionViewCell.identifier, for: indexPath) as! DrivingCollectionViewCell
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        cell.writeDateLabel.text = dummy[indexPath.row].timeStamp
        cell.driveDistenceLabel.text = String("\(dummy[indexPath.row].driveDistance)km")
        cell.departDistenceLabel.text = String("\(dummy[indexPath.row].departDistance)km")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - Constants.horizontalMargin * 4), height: 100) //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
