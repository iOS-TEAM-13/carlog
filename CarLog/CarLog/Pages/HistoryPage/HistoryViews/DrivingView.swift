//
//  DrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import UIKit

class DrivingView: UIView {

    lazy var drivingTableView: UITableView = {
        let drivingTableView = UITableView()
        drivingTableView.dataSource = self
        drivingTableView.delegate = self
        drivingTableView.register(DrivingCell.self, forCellReuseIdentifier: DrivingCell.identifier)
        drivingTableView.backgroundColor = .gray
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrivingCell.identifier, for: indexPath) as! DrivingCell
        
        return cell
    }
    
    
}
