import UIKit

class GasStationDetailView: UIView {
    
    // 라벨, 이미지 등 ui 요소
    
    private let nameLabel = {
        let label = UILabel()
        label.text = "광교 SK 주유소"
        label.textColor = .black
        label.font = Constants.fontJua20
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
        label.text = "2023.10.14"
        label.textColor = .black
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
            make.leftMargin.equalToSuperview().offset(17)
            make.bottomMargin.equalToSuperview().offset(-234)
        }
        
        storeImage.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(17)
            make.bottomMargin.equalToSuperview().offset(-194)
            make.width.equalTo(39)
            make.height.equalTo(31)
        }
        
        carWashImage.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(72)
            make.bottomMargin.equalToSuperview().offset(-194)
            make.width.equalTo(39)
            make.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-154)
        }
        
        greenOilImage.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(35)
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-95)
        }
        
        yellowOilImage.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(35)
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-42)
        }
        
        greenOilPriceLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(77)
            make.bottomMargin.equalToSuperview().offset(-101)
        }
        
        yellowOilPriceLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(77)
            make.bottomMargin.equalToSuperview().offset(-48)
        }
        
    }
    
    
}
