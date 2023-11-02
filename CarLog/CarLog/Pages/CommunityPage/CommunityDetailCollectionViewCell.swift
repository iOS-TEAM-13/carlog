//
//  CommunityDetailCollectionViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/1/23.
//

import UIKit

class CommunityDetailCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
       }()
    
    private let pageControl: UIPageControl = {
           let pageControl = UIPageControl()
           pageControl.currentPage = 0
           pageControl.currentPageIndicatorTintColor = .white
           pageControl.pageIndicatorTintColor = .systemGray
           return pageControl
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           contentView.addSubview(imageView)
           addSubview(pageControl)
           imageView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
                   pageControl.snp.makeConstraints { make in
                       make.centerX.equalToSuperview()
                       make.bottom.equalToSuperview().offset(-10)
                   }
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func configure(with imageName: String) {
           imageView.image = UIImage(named: imageName)
           pageControl.numberOfPages = imageName.count
       }
   }
