//
//  FuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class FuelingView: UIView {

    lazy var fuelingTableView: UITableView = {
        let fuelingTableView = UITableView()
        fuelingTableView.dataSource = self
        fuelingTableView.delegate = self
        fuelingTableView.register(FuelingCell.self, forCellReuseIdentifier: FuelingCell.identifier)
        fuelingTableView.backgroundColor = .orange
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FuelingCell.identifier, for: indexPath) as! FuelingCell
        
        return cell
    }
    
    
}
