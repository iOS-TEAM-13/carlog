import UIKit

import SnapKit

class OilModelView: UIView {
    
     let categoryCollectionHorizontal = UICollectionViewFlowLayout()

    lazy var OilCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false // 스크롤바 삭제
        collection.backgroundColor = .clear
        categoryCollectionHorizontal.scrollDirection = .horizontal
        collection.collectionViewLayout = categoryCollectionHorizontal // 수평으로 바꿈
        return collection
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.customLabel(text: "?", textColor: .white, font: Constants.fontJua36 ?? UIFont(), alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "이 전", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var spaceView = UIView()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popButton, spaceView, nextButton])
        stackView.customStackView(spacing: 40, axis: .horizontal, alignment: .fill)
        return stackView
    }()

    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(OilCollectionView)
        addSubview(buttonStackView)
        
        OilCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(100)
            make.leading.equalTo(safeArea.snp.leading).offset(20)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(OilCollectionView.snp.bottom).offset(50)
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
