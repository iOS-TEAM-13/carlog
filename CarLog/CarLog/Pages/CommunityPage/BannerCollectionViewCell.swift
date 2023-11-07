//
//  BannerCollectionViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/31/23.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.backgroundColor = .backgroundCoustomColor
            contentView.addSubview(bannerImageView)
            bannerImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    
    func configure(with imageName: String) {
        bannerImageView.image = UIImage(named: imageName)
    }
}
