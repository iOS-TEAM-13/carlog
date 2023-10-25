import SnapKit
import UIKit

class GasStationDetailView: UIView {
    // 라벨, 이미지 등 ui 요소
    
    var gasStation: GasStationDetailSummary? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        nameLabel.text = gasStation?.osNm
        storeImage.isHidden = gasStation?.cvsYn != "Y"
        carWashImage.isHidden = gasStation?.carWashYn != "Y"
        let oilPrices = gasStation?.oilPrice ?? []
        if let latestOilPrice = oilPrices.max(by: { $0.tradeDt < $1.tradeDt }) {
            dateLabel.text = "\(latestOilPrice.tradeDt ?? "")" + "기준"
            } else {
                dateLabel.text = "날짜 정보 없음"
            }
            
            if let yellowOilPrice = oilPrices.first(where: { $0.prodcd == "B027" }) {
                yellowOilPriceLabel.text = "휘발유 \(yellowOilPrice.price)원"
            } else {
                yellowOilPriceLabel.text = "휘발유 정보 없음"
            }
        if let greenOilPrice = oilPrices.first(where: { $0.prodcd == "D047"}) {
            greenOilPriceLabel.text = "경유 \(greenOilPrice.price)원"
        } else {
            greenOilPriceLabel.text = "경유 정보 없음"
        }
    }
    
    private let nameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let storeImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "store") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let carWashImage = {
        let imageView = UIImageView()
        if let image = UIImage(named: "carwash") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "2023.10.14 기준"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return label
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(storeImage)
        addSubview(carWashImage)
        addSubview(dateLabel)
        addSubview(greenOilImage)
        addSubview(yellowOilImage)
        addSubview(greenOilPriceLabel)
        addSubview(yellowOilPriceLabel)
        
        self.backgroundColor = .white
        
        nameLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-175)
            make.width.equalTo(359)
        }
        
        storeImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-75)
            make.bottomMargin.equalToSuperview().offset(-125)
            make.width.equalTo(39)
            make.height.equalTo(31)
        }
        
        carWashImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottomMargin.equalToSuperview().offset(-125)
            make.width.equalTo(39)
            make.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-129)
        }
        
        greenOilImage.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(35)
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-69)
        }
        
        yellowOilImage.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(35)
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-11)
        }
        
        greenOilPriceLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(94)
            make.bottomMargin.equalToSuperview().offset(-78)
        }
        
        yellowOilPriceLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(94)
            make.bottomMargin.equalToSuperview().offset(-20)
        }
        
    }
    
    
}
