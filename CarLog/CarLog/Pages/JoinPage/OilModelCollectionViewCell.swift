




import UIKit

class OilModelCollectionViewCell: UICollectionViewCell {
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.customLabel(text: "휘발유", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(label)
        
      
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
