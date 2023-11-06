import UIKit

import SnapKit

class DetailMiddleTableViewCell: UITableViewCell {
    let imageName = ["image1", "image2", "image3"]
    
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 361, height: 346)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
            
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.borderColor = UIColor.red.cgColor
        collectionView.layer.borderWidth = 2.0
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailMiddleCollectionViewCell")
        return collectionView
    }()
        
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "spaner"), for: .normal)
        button.setImage(UIImage(named: "spaner.fill"), for: .selected)
        button.tintColor = .red
        // button.addTarget(CommunityDetailPageViewController.self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
        
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.text = "264"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()
    
    lazy var likeButtonstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, likeCount, UIView()])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return stackView
    }()

    // textview 로 수정
    lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "카 \n로 \n그 \n언 \n더 \n독"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
        
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .green
        addSubview(photoCollectionView)
        addSubview(likeButtonstackView)
        addSubview(mainText)
        addSubview(line)
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.isPagingEnabled = true
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.horizontalMargin)
            make.height.equalTo(300)
        }
        
        likeButtonstackView.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(mainText.snp.top).offset(-Constants.horizontalMargin)
        }
        
        mainText.snp.makeConstraints { make in
            make.top.equalTo(likeButtonstackView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(line.snp.top).offset(-Constants.horizontalMargin)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(Constants.verticalMargin)
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(1.5)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailMiddleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMiddleCollectionViewCell", for: indexPath) as! CommunityDetailCollectionViewCell
        cell.configure(with: imageName[indexPath.row])
        return cell
    }
}
