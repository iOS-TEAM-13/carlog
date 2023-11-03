//
//  CustomAnnotationView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/03.
//

import UIKit

import MapKit
import SnapKit

class CustomAnnotationView: MKAnnotationView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.alpha = 0.9
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua8, weight: .bold)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.text = "주유소 명"
        return label
    }()
    
    private lazy var gasolineImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.image = UIImage(named: "gasoline")
        return view
    }()
    
    private lazy var dieselImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.image = UIImage(named: "diesel")
        return view
    }()
    
    private lazy var gasolinePriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold)
        label.textColor = .black
        label.text = "휘발유"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dieselPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold)
        label.textColor = .black
        label.text = "경유"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var indicator = UIActivityIndicatorView()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(indicator)
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(gasolineImageView)
        backgroundView.addSubview(dieselImageView)
        backgroundView.addSubview(gasolinePriceLabel)
        backgroundView.addSubview(dieselPriceLabel)

        backgroundView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView).inset(2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(10)
        }

        gasolineImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(backgroundView).inset(5)
            $0.width.height.equalTo(20)
        }

        dieselImageView.snp.makeConstraints {
            $0.top.equalTo(gasolineImageView.snp.bottom)
            $0.leading.bottom.equalTo(backgroundView).inset(5)
            $0.width.height.equalTo(20)
        }

        gasolinePriceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-2)
            $0.leading.equalTo(gasolineImageView.snp.trailing)
            $0.trailing.equalTo(backgroundView).inset(5)
        }

        dieselPriceLabel.snp.makeConstraints {
            $0.top.equalTo(gasolinePriceLabel.snp.bottom)
            $0.leading.equalTo(dieselImageView.snp.trailing)
            $0.trailing.bottom.equalTo(backgroundView).inset(5)
        }
    }
    
//    private func configureUI() {
//        addSubview(indicator)
//        addSubview(backgroundView)
//        backgroundView.addSubview(titleLabel)
//        backgroundView.addSubview(gasolineImageView)
//        backgroundView.addSubview(dieselImageView)
//        backgroundView.addSubview(gasolinePriceLabel)
//        backgroundView.addSubview(dieselPriceLabel)
//
//        backgroundView.snp.makeConstraints {
//            $0.width.equalTo(60)
//            $0.height.equalTo(30)
//        }
//
//        gasolinePriceLabel.snp.makeConstraints {
//            $0.top.leading.trailing.equalTo(backgroundView.safeAreaLayoutGuide)
//        }
//
//        dieselPriceLabel.snp.makeConstraints {
//            $0.top.equalTo(gasolinePriceLabel.snp.bottom)
//            $0.leading.trailing.bottom.equalTo(backgroundView.safeAreaLayoutGuide)
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        gasolineImageView.image = nil
        dieselImageView.image = nil
        gasolinePriceLabel.text = nil
        dieselPriceLabel.text = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? CustomAnnotation else { return }

        if let title = annotation.title, let gasoline = annotation.gasolinePrice, let diesel = annotation.dieselPrice {
            titleLabel.text = " \(title) "
            gasolinePriceLabel.text = " 휘 \(gasoline) "
            dieselPriceLabel.text = " 경 \(diesel) "
        }
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bounds.size = CGSize(width: 100, height: 50)
        centerOffset = CGPoint(x: 0, y: 50)
    }
}
