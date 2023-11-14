import UIKit

class BannerCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 80)
        layout.minimumLineSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
