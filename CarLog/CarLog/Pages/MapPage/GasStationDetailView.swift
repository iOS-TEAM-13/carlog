import SnapKit
import UIKit

class GasStationDetailView: UIView {
    
    // 라벨, 이미지 등 ui 요소
    
    private let nameLabel = {
        let label = UILabel()
        label.text = "가나다라마바사아자차카타파하아야어여야"
        label.textColor = .black
        label.font = Constants.fontJua24
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
        
        if shouldAnimateLabel(label: nameLabel) {
            animateLabel(label: nameLabel)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(20)
            make.bottomMargin.equalToSuperview().offset(-175)
        }
        
        storeImage.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(279)
            make.bottomMargin.equalToSuperview().offset(-125)
            make.width.equalTo(39)
            make.height.equalTo(31)
        }
        
        carWashImage.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(334)
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
    
    func shouldAnimateLabel(label: UILabel) -> Bool {
        guard let labelText = label.text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(with: CGSize(width:  .greatestFiniteMagnitude, height: label.frame.height), options:  .usesLineFragmentOrigin, attributes:  [.font: label.font!], context: nil ).size
        return labelTextSize.width > 359
    }
    
    func animateLabel(label: UILabel) {
            guard let labelText = label.text else {
                return
            }
            
            label.sizeToFit()
            
            let offScreenLeft = CGAffineTransform(translationX: -label.bounds.width, y: 0)
            let offScreenRight = CGAffineTransform(translationX: self.bounds.width + labelText.width(of: label.font) - 50, y: 0)
            
            label.transform = offScreenRight
            
            UIView.animate(withDuration: 14.0, delay: 0, options: [.curveLinear, .repeat], animations: {
                label.transform = offScreenLeft
            }, completion: nil)
        }
    
    
}
