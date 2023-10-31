import UIKit
import SnapKit

class CommunityPageViewController: UIViewController {
    
    private var items: [String] = []
    
    private let editFloatingButton: UIButton = {
        let floatingButton = UIButton()
        let editImage = UIImage(named: "edit")
        floatingButton.setImage(editImage, for: .normal)
        floatingButton.backgroundColor = .mainNavyColor
        floatingButton.layer.cornerRadius = 30
        floatingButton.layer.shadowRadius = 10
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        return floatingButton
    }()
    
    private lazy var communityColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 357, height: 321)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        communityColletionView.register(CommunityPageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(communityColletionView)
        view.addSubview(editFloatingButton)
        
        communityColletionView.snp.makeConstraints { make in
               make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
               make.left.right.equalToSuperview()
               make.bottom.equalTo(editFloatingButton.snp.top).offset(-10) // 플로팅 버튼 위에 위치하도록 설정
           }
        
        editFloatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
          make.rightMargin.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-102)
        }
    }
    
    @objc func floatingButtonTapped() {
        
        items.append("New Item")
        print("새 항목 추가")
        communityColletionView.reloadData()
        //📌네비게이션 화면 전환 기능
//        let editPage = EditPageViewController()
//                navigationController?.pushViewController(editPage, animated: true)
    }
    
}

extension CommunityPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 324, height: 321)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommunityPageCollectionViewCell
//            cell.titleLabel.text = items[indexPath.item]
        return cell
    }
    
    
}
