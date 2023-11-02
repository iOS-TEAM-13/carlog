//
//  CommunityDetailPageViewController.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/1/23.
//

import UIKit
import SnapKit

class CommunityDetailPageViewController: UIViewController {
    
    let imageName = ["image1", "image2", "image3"]
    //좋아요 버튼 설정
    private var isLiked = false {
            didSet {
                updateLikeButton()
            }
        }
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "달려라 달려라~"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "왕바우"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return label
    }()
    
    private let dateLabel : UILabel = {
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
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityDetailCell")
        return collectionView
    }()
    
    private let likeButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "spaner"), for: .normal)
            button.setImage(UIImage(named: "spaner.fill"), for: .selected)
       // button.contentMode = .scaleAspectFill
       // button.backgroundColor = .blue
            button.tintColor = .red
            button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return button
        }()
    
    private let likeCount: UILabel = {
        let label = UILabel()
        label.text = "264"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()
    
    private let mainText: UILabel = {
        let label = UILabel()
        label.text = "카 \n로 \n그 \n언 \n더 \n독"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold)
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonSkyBlueColor
        button.layer.cornerRadius = 21
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        //버튼 내부 사진 추가
        button.setImage(UIImage(named: "chaticon"), for: .normal)
        //라벨 추가
           button.setTitle("댓글 3개", for: .normal)
        button.setTitleColor(.black, for: .normal)
           button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: 15, weight: .bold)
           button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 16)
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //네비게이션 바 버튼 이미지 설정
        let dotsImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
         let dotsButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(dotsButtonTapped))
         navigationItem.rightBarButtonItem = dotsButton
        
        //컬렉션뷰 셀을 한장씩 넘기게 설정
        photoCollectionView.isPagingEnabled = true
        
        setupUI()
     }
//dots 버튼 눌렸을때 동작(드롭다운 메뉴)
    @objc func dotsButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let action1 = UIAlertAction(title: "신고하기", style: .default) { action in
                print("신고 완료")
                // 옵션 1을 눌렀을 때의 동작을 여기에 추가
            }

            let action2 = UIAlertAction(title: "삭제하기", style: .default) { action in
                print("삭제 완료")
                // 옵션 2를 눌렀을 때의 동작을 여기에 추가
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

            actionSheet.addAction(action1)
            actionSheet.addAction(action2)
            actionSheet.addAction(cancelAction)

            present(actionSheet, animated: true, completion: nil)
        }
    
    @objc func commentButtonTapped() {
        let commentVC = CommentViewController()
        commentVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 모달 표시
            present(commentVC, animated: true, completion: nil)
        
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(userNameLabel)
        view.addSubview(dateLabel)
        view.addSubview(photoCollectionView)
        view.addSubview(likeButton)
        view.addSubview(likeCount)
        view.addSubview(mainText)
        view.addSubview(commentButton)
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.equalToSuperview().offset(16)
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
        
        commentButton.snp.makeConstraints { make in
            make.width.equalTo(117)
            make.height.equalTo(42)
            make.top.equalTo(mainText.snp.bottom).offset(12)
          make.leftMargin.equalToSuperview().offset(138)
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

extension CommunityDetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityDetailCell", for: indexPath) as! CommunityDetailCollectionViewCell
        cell.configure(with: imageName[indexPath.row])
                return cell
    }
    
    
}
