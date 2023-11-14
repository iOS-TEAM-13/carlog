//
//  GasStationDetailView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class GasStationDetailView: UIView {
    lazy var nameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize24, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var addressLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var telLabel = {
        let label = UILabel()
        label.text = "xxx-xxxx"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium)
        return label
    }()

    lazy var dateLabel = {
        let label = UILabel()
        label.text = "2023.10.14 기준"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium)
        return label
    }()

    lazy var storeImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "store")
        imageView.tintColor = .black
        return imageView
    }()

    lazy var carWashImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "carwash")
        imageView.tintColor = .black
        return imageView
    }()

    lazy var greenOilImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greenoil")
        return imageView
    }()

    lazy var yellowOilImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yellowoil")
        return imageView
    }()

    lazy var greenOilPriceLabel = {
        let label = UILabel()
        label.text = "경유 2000원"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium)
        return label
    }()

    lazy var yellowOilPriceLabel = {
        let label = UILabel()
        label.text = "휘발유 2000원"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium)
        return label
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
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(telLabel)
        addSubview(dateLabel)
        addSubview(storeImage)
        addSubview(carWashImage)
        addSubview(greenOilImage)
        addSubview(yellowOilImage)
        addSubview(greenOilPriceLabel)
        addSubview(yellowOilPriceLabel)

        backgroundColor = .white
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }

        telLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(telLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }

        storeImage.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }

        carWashImage.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.trailing.equalTo(storeImage.snp.leading).inset(-Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }

        greenOilImage.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }

        greenOilPriceLabel.snp.makeConstraints {
            $0.top.equalTo(greenOilImage)
            $0.leading.equalTo(greenOilImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.centerY.equalTo(greenOilImage)
        }

        yellowOilImage.snp.makeConstraints {
            $0.top.equalTo(greenOilImage.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.width.height.equalTo(50)
        }

        yellowOilPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(yellowOilImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.centerY.equalTo(yellowOilImage)
        }
    }
}
