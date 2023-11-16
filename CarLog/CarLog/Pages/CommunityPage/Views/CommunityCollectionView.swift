import UIKit

class CommunityCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        self.isScrollEnabled = true
        self.backgroundColor = .backgroundCoustomColor
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        self.register(CommunityPageCollectionViewCell.self, forCellWithReuseIdentifier: CommunityPageCollectionViewCell.identifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
