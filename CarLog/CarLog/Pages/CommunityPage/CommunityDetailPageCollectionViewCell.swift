//
//  CommunityDetailPageCollectionViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/6/23.
//

import UIKit

class CommunityDetailPageCollectionViewCell: UICollectionViewCell {
    
    let imageName = ["image1", "image2", "image3"]
    
    //좋아요 버튼 설정
    private var isLiked = false {
            didSet {
                updateLikeButton()
            }
        }
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "달려라 달려라~"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var userNameLabel : UIButton = {
        let button = UIButton()
        button.setTitle("왕바우", for: .normal)  // "게시"라는 텍스트 설정
        button.setTitleColor(.black, for: .normal)  // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)  // 폰트와 크기 설정
        button.backgroundColor = .clear  // 버튼의 배경색 설정
      //  button.layer.cornerRadius = 5  // 버튼의 모서리 둥글게 설정
        // button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "2023.11.02"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 361, height: 346)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityDetailCell")
        return collectionView
    }()
    
    lazy var likeButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "spaner"), for: .normal)
            button.setImage(UIImage(named: "spaner.fill"), for: .selected)
            button.tintColor = .red
        button.addTarget(CommunityDetailPageViewController.self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return button
        }()
    
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.text = "264"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()
    //textview 로 수정
    lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "카 \n로 \n그 \n언 \n더 \n독"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        
        //컬렉션뷰 셀을 한장씩 넘기게 설정
        //photoCollectionView.isPagingEnabled = true

        addUI()
        setupUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func addUI() {
        addSubview(titleLabel)
        addSubview(userNameLabel)
        addSubview(dateLabel)
        addSubview(photoCollectionView)
        addSubview(likeButton)
        addSubview(likeCount)
        addSubview(mainText)
        addSubview(line)
        
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.rightMargin.equalToSuperview().offset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(12)
            make.rightMargin.equalToSuperview().offset(-16)
        }
        
        photoCollectionView.snp.makeConstraints { make in
                    make.top.equalTo(dateLabel.snp.bottom).offset(12)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(CGSize(width: 361, height: 346))
                }
        
        likeButton.snp.makeConstraints { make in
                    make.top.equalTo(photoCollectionView.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(16)
                    make.size.equalTo(CGSize(width: 24, height: 24))
                }
        
        likeCount.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(photoCollectionView.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(56)
        }
        
        mainText.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.top.equalTo(likeButton.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(16)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(16)
            make.rightMargin.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
    }
    
    
    //좋아요 버튼 눌렀을 떄 동작 구현
    @objc func likeButtonTapped() {
            isLiked.toggle()
        }

        private func updateLikeButton() {
            likeButton.isSelected = isLiked
        }
    
}

extension CommunityDetailPageCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityDetailCell", for: indexPath) as! CommunityDetailCollectionViewCell
        cell.configure(with: imageName[indexPath.row])
                return cell
    }
    
    
}
