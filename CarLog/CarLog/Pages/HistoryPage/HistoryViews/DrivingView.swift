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
    ]

    lazy var drivingTableView: UITableView = {
        let drivingTableView = UITableView()
        drivingTableView.dataSource = self
        drivingTableView.delegate = self
        drivingTableView.register(DrivingCell.self, forCellReuseIdentifier: DrivingCell.identifier)
        return drivingTableView
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
        addSubview(drivingTableView)
        drivingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension DrivingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrivingCell.identifier, for: indexPath) as! DrivingCell
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        cell.writeDateLabel.text = dummy[indexPath.row].timeStamp
        cell.driveDistenceLabel.text = String("\(dummy[indexPath.row].driveDistance)km")
        cell.departDistenceLabel.text = String("\(dummy[indexPath.row].departDistance)km")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
