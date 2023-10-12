//
//  CarouselCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class CarouselViewCell: UICollectionViewCell {
    static let identifier = "CarouselViewCell"
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    func bind(view: UIView) {
        addSubview(customView)
        customView = view
        view.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(600)
        }
    }
    
    private func setLayout() {
        contentView.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(600)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

