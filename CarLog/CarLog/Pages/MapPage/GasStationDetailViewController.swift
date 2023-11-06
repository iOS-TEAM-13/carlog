import UIKit

import SnapKit

class GasStationDetailViewController: UIViewController {
    private let gasStation: CustomGasStation?
    
    private let nameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let addressLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let telLabel = {
        let label = UILabel()
        label.text = "xxx-xxxx"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "2023.10.14 기준"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return label
    }()
    
    private let storeImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "store") {
            imageView.image = image
        }
        imageView.tintColor = .black
        return imageView
    }()
    
    private let carWashImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "carwash") {
            imageView.image = image
        }
        imageView.tintColor = .black
        return imageView
    }()
    
    private let greenOilImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "greenoil") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let yellowOilImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "yellowoil") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let greenOilPriceLabel = {
        let label = UILabel()
        label.text = "경유 2000원"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return label
    }()
    
    private let yellowOilPriceLabel = {
        let label = UILabel()
        label.text = "휘발유 2000원"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return label
    }()
    
    init (data: CustomGasStation) {
        self.gasStation = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        
        updateUI()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(telLabel)
        view.addSubview(dateLabel)
        view.addSubview(storeImage)
        view.addSubview(carWashImage)
        view.addSubview(greenOilImage)
        view.addSubview(yellowOilImage)
        view.addSubview(greenOilPriceLabel)
        view.addSubview(yellowOilPriceLabel)
        
        view.backgroundColor = .white
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin * 2)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-Constants.verticalMargin * 2)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        telLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(telLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        storeImage.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-Constants.verticalMargin * 2)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }
        
        carWashImage.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-Constants.verticalMargin * 2)
            $0.leading.equalTo(storeImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }
        
        greenOilImage.snp.makeConstraints {
            $0.top.equalTo(storeImage.snp.bottom).inset(-Constants.verticalMargin * 2)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(50)
        }
        
        greenOilPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(greenOilImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.centerY.equalTo(greenOilImage)
        }
        
        yellowOilImage.snp.makeConstraints {
            $0.top.equalTo(greenOilImage.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.width.height.equalTo(50)
        }
        
        yellowOilPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(yellowOilImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.centerY.equalTo(yellowOilImage)
        }
    }
    
    private func updateUI() {
        nameLabel.text = gasStation?.name
        storeImage.image = gasStation?.cvsYn !=  "Y" ? UIImage(systemName: "x.square") : UIImage(named: "store")
        carWashImage.image = gasStation?.carWashYn !=  "Y" ? UIImage(systemName: "x.square") : UIImage(named: "carwash")
        let oilPrices = gasStation?.oilPrice ?? []
        if let latestOilPrice = oilPrices.max(by: { $0.tradeDt < $1.tradeDt }) {
            dateLabel.text = "기준: \(latestOilPrice.tradeDt)"
        } else {
            dateLabel.text = "날짜 정보 없음"
        }
        
        addressLabel.text = gasStation?.address

        telLabel.text = gasStation?.tel
            
        if let yellowOilPrice = oilPrices.first(where: { $0.prodcd == "B027" }) {
            yellowOilPriceLabel.text = "휘발유: \(yellowOilPrice.price)원"
        } else {
            yellowOilPriceLabel.text = "휘발유 정보 없음"
        }
        
        if let greenOilPrice = oilPrices.first(where: { $0.prodcd == "D047" }) {
            greenOilPriceLabel.text = "경유: \(greenOilPrice.price)원"
        } else {
            greenOilPriceLabel.text = "경유 정보 없음"
        }
    }
}
