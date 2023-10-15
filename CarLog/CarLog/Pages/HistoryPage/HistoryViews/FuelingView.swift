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
        Fueling(timeStamp: "2020.10.11", totalDistance: 17777, price: 1777, count: 55, totalPrice: 89999),
        Fueling(timeStamp: "2020.10.12", totalDistance: 17787, price: 1776, count: 56, totalPrice: 100000),
        Fueling(timeStamp: "2020.10.13", totalDistance: 17797, price: 1800, count: 55.44, totalPrice: 123999),
    ]

    lazy var fuelingTableView: UITableView = {
        let fuelingTableView = UITableView()
        fuelingTableView.dataSource = self
        fuelingTableView.delegate = self
        fuelingTableView.register(FuelingCell.self, forCellReuseIdentifier: FuelingCell.identifier)
        return fuelingTableView
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
        addSubview(fuelingTableView)
        fuelingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FuelingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FuelingCell.identifier, for: indexPath) as! FuelingCell
        
        cell.writeDateLabel.text = dummy[indexPath.row].timeStamp
        cell.priceLabel.text = String("\(dummy[indexPath.row].price)원")
        cell.totalPriceLabel.text = String("\(dummy[indexPath.row].totalPrice)원")
        cell.countLabel.text = String("\(dummy[indexPath.row].count)L")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
