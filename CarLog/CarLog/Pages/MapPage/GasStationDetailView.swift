import SnapKit
import UIKit

class GasStationDetailView: UIView {
    
    // 라벨, 이미지 등 ui 요소
    
    private let nameLabel = {
        let label = UILabel()
        label.text = "가나다라마바사아자차카타파하아야어여야랄랄라"
        label.textColor = .black
        label.font = Constants.fontJua24
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
        label.font = Constants.fontJua16
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
        label.font = Constants.fontJua20
        return label
    }()
    
    private let yellowOilPriceLabel = {
        let label = UILabel()
        label.text = "휘발유 2000원"
        label.textColor = .black
        label.font = Constants.fontJua20
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
