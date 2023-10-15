import UIKit

import SnapKit

class OilModelView: UIView {
    let duplicateComponents = DuplicateComponents()
    let categoryCollectionHorizontal = UICollectionViewFlowLayout()

    lazy var oilCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false // 스크롤바 삭제
        collection.backgroundColor = .clear
        categoryCollectionHorizontal.scrollDirection = .horizontal
        collection.collectionViewLayout = categoryCollectionHorizontal // 수평으로 바꿈
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var popButton: UIButton = duplicateComponents.popButton()
    lazy var nextButton: UIButton = duplicateComponents.nextButton()
    lazy var spaceView = UIView()
    lazy var buttonStackView: UIStackView = duplicateComponents.buttonStackView(list: [popButton, spaceView, nextButton])

    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(oilCollectionView)
        addSubview(buttonStackView)
        
        oilCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea.snp.top).offset(155)
            make.width.equalTo(300)
            make.height.equalTo(250)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(oilCollectionView.snp.bottom).offset(50)
            make.leading.equalTo(safeArea.snp.leading).offset(20)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
