import UIKit

class OilModelCollectionViewCell: UICollectionViewCell {
    var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 250)

        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
        label.text = "휘발유"
        label.textAlignment = .center
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
