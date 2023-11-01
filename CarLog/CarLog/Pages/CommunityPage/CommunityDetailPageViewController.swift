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
        layout.itemSize = CGSize(width: 332, height: 294)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityDetailCell")
        return collectionView
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
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(userNameLabel)
        view.addSubview(dateLabel)
        view.addSubview(photoCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(329)
            make.topMargin.leftMargin.equalToSuperview().offset(32)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(32)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(userNameLabel.snp.bottom).offset(6)
            make.leftMargin.equalToSuperview().offset(32)
        }
        
        photoCollectionView.snp.makeConstraints { make in
                    make.top.equalTo(dateLabel.snp.bottom).offset(21)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(CGSize(width: 332, height: 294))
                }
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
