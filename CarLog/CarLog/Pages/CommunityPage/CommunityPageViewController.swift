import SnapKit
import UIKit

class CommunityPageViewController: UIViewController {
    private var items: [Post] = [] // 커뮤니티 셀 배열
    
    private var banners: [String] = ["a", "b", "c"] // 배너 셀 배열
    
    private var timer: Timer? // 배너 일정 시간 지날때 자동으로 바뀜
    
    private lazy var editFloatingButton: UIButton = {
        let floatingButton = UIButton()
        let editImage = UIImage(named: "edit")
        floatingButton.setImage(editImage, for: .normal)
        floatingButton.backgroundColor = .mainNavyColor
        floatingButton.layer.cornerRadius = 25
        floatingButton.alpha = 1.0
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        return floatingButton
    }()
    
    private lazy var communityColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 357, height: 321)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .backgroundCoustomColor
        view.clipsToBounds = true
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 80) // 배너의 너비를 뷰의 너비로 설정
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        communityColletionView.register(CommunityPageCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityCell")
        communityColletionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        
        setupUI()
        loadPostFromFireStore()
        startBannerTimer()
    }
    
    func setupUI() {
        view.addSubview(communityColletionView)
        view.addSubview(editFloatingButton)
        view.addSubview(bannerCollectionView)
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80) // 원하는 높이 설정
        }
        
        communityColletionView.snp.makeConstraints { make in
            // make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        editFloatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.rightMargin.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-102)
        }
    }

    // 배너 컬렉션 뷰 셀 전환 속도 조정
    private func startBannerTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextBanner), userInfo: nil, repeats: true)
    }
    
    private func loadPostFromFireStore() {
        FirestoreService.firestoreService.loadPosts { posts in
            if let posts = posts {
                for post in posts {
                    if let id = post.id,
                       let title = post.title,
                       let content = post.content,
                       let userEmail = post.userEmail,
                       let timeStamp = post.timeStamp
                    {
                        let imageURLs = post.image.compactMap { $0 }
                        let loadedPost = Post(
                            id: id,
                            title: title,
                            content: content,
                            image: imageURLs,
                            userEmail: userEmail,
                            timeStamp: timeStamp
                        )
                        self.items.append(loadedPost)
                    }
                }
                DispatchQueue.main.async {
                    self.communityColletionView.reloadData()
                }
            } else {
                print("데이터를 가져오는 중 오류 발생")
            }
        }
    }
    
    @objc private func scrollToNextBanner() {
        let currentOffset = bannerCollectionView.contentOffset.x
        let nextOffset = currentOffset + bannerCollectionView.frame.width
        if nextOffset < bannerCollectionView.contentSize.width {
            bannerCollectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        } else {
            bannerCollectionView.setContentOffset(.zero, animated: true)
        }
    }

    @objc func floatingButtonTapped() {
        let editPage = AddCommunityPageViewController()
        navigationController?.pushViewController(editPage, animated: true)
    }
}

extension CommunityPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return banners.count
        } else if collectionView == communityColletionView {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
            cell.configure(with: banners[indexPath.item])

            return cell
        } else if collectionView == communityColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityCell", for: indexPath) as! CommunityPageCollectionViewCell
            let post = items[indexPath.item]
                
            FirestoreService.firestoreService.fetchNickName(userEmail: post.userEmail ?? "") { nickName in
                cell.userName.text = nickName
                cell.titleLabel.text = post.title
                cell.mainTextLabel.text = post.content
                if let imageURL = post.image.first, let imageUrl = imageURL {
                    // 이미지를 비동기적으로 가져오기
                    URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.collectionViewImage.image = image
                            }
                        }
                    }.resume()
                }
            }
                
            return cell
        }
        return UICollectionViewCell()
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else if collectionView == communityColletionView {
            return CGSize(width: 357, height: 321)
        }
        return CGSize.zero
    }

    // 커뮤니티 컬렉션 뷰 셀 사이의 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == communityColletionView {
            return 12 // 커뮤니티 컬렉션 뷰 셀 사이의 간격을 12로 설정
        }
        return 0 // 다른 컬렉션 뷰에 대해서는 0 또는 원하는 값으로 설정
    }

    // 셀 클릭 시 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == communityColletionView {
            let detailViewController = CommunityDetailPageViewController()

            // 선택한 포스트를 가져와서 detailViewController에 설정
            let selectedPost = items[indexPath.item]
            detailViewController.selectedPost = selectedPost

            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
