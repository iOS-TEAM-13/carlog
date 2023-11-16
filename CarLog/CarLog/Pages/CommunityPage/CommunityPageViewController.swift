import SnapKit
import UIKit

class CommunityPageViewController: UIViewController {
    private var posts: [Post] = [] // 커뮤니티 셀 배열
    private var comments: [String:[Comment]] = [:]
    //배너 URL
    private var bannerURL: [String] = [
        "https://luttoli.notion.site/1318cb2f60214cb2ba100740583ac602?pvs=4",
        "https://luttoli.notion.site/4041e205c36549b5a99ceb938741353c?pvs=4",
        "https://luttoli.notion.site/3a4a85d672b84685a7fefbd288f6e889?pvs=4",
        "https://comfortable-polyanthus-e65.notion.site/3-9bd71c5e295c4545a3b329cd53dafa4f?pvs=4"
    ]
    //배너이미지
    private var bannerImages: [String] = ["beginner", "Fuelefficiency", "winterDriving", "beginnerTips"]
    private var timer: Timer? // 배너 일정 시간 지날때 자동으로 바뀜
    
    private lazy var bannerCollectionView = BannerCollectionView()
    private lazy var communityCollectionView = CommunityCollectionView()
    private lazy var editFloatingButton = CustomFloatingButton(image: UIImage(named: "edit"))
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        communityCollectionView.register(CommunityPageCollectionViewCell.self, forCellWithReuseIdentifier: CommunityPageCollectionViewCell.identifier)
        communityCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        editFloatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        
        setupUI()
        loadPostFromFireStore()
        startBannerTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPostFromFireStore()
    }
    
    func setupUI() {
        view.addSubview(communityCollectionView)
        view.addSubview(editFloatingButton)
        view.addSubview(bannerCollectionView)
        view.addSubview(indicator)
        indicator.center = view.center
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(Constants.horizontalMargin)
            make.right.equalToSuperview().offset(-Constants.horizontalMargin)
            make.height.equalTo(80) // 원하는 높이 설정
        }
        
        communityCollectionView.snp.makeConstraints { make in
            // make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(Constants.verticalMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        // 커뮤니티 마지막 셀 safearea 마진
        communityCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constants.horizontalMargin, right: 0)
        
        editFloatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin - 12)
            make.bottom.equalToSuperview().offset(-102 - 12)
        }
    }
    
    // 배너 컬렉션 뷰 셀 전환 속도 조정
    private func startBannerTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextBanner), userInfo: nil, repeats: true)
    }
    
    private func loadPostFromFireStore() {
        guard let userEmail = Constants.currentUser.userEmail else {
            print("사용자 이메일 정보가 없습니다.")
            indicator.stopAnimating()
            return
        }
             
        indicator.startAnimating()
        FirestoreService.firestoreService.loadPosts(excludingBlockedPostsFor: userEmail) { [weak self] posts in
            guard let self = self else { return }
            if let posts = posts {
                self.posts = posts
                for post in posts {
                    self.loadComment(email: userEmail,id: post.id ?? "") {
                        self.communityCollectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            } else {
                print("데이터를 가져오는 중 오류 발생")
                    self.indicator.stopAnimating()
            }
        }
    }

    private func loadComment(email: String, id: String, completion: @escaping () -> Void) {
        FirestoreService.firestoreService.loadComments(excludingBlockedPostsFor: email , postID: id) { comments in
            self.comments[id] = comments
            completion()
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
        let editPage = AddCommunityPageViewController(post: nil)
        navigationController?.pushViewController(editPage, animated: true)
    }
}

extension CommunityPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return bannerURL.count
        } else if collectionView == communityCollectionView {
            return posts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            cell.configure(with: bannerImages[indexPath.item])
            return cell
        } else if collectionView == communityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityPageCollectionViewCell.identifier, for: indexPath) as! CommunityPageCollectionViewCell
            let post = posts[indexPath.item]
            if let imageURL = post.image.first {
                cell.bind(userName: post.userName, title: post.title, content: post.content, image: imageURL, spanerCount: post.emergency?.filter { $0.value == true }.count, commentCount: self.comments[post.id ?? ""]?.count)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else if collectionView == communityCollectionView {
            return CGSize(width: collectionView.bounds.width - Constants.horizontalMargin * 4, height: 321)
        }
        return CGSize.zero
    }
    
    // 커뮤니티 컬렉션 뷰 셀 사이의 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == communityCollectionView {
            return 12 // 커뮤니티 컬렉션 뷰 셀 사이의 간격을 12로 설정
        }
        return 0 // 다른 컬렉션 뷰에 대해서는 0 또는 원하는 값으로 설정
    }
    
    // 셀 클릭 시 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == communityCollectionView {
            let detailViewController = CommunityDetailPageViewController()
            
            // 선택한 포스트를 가져와서 detailViewController에 설정
            let selectedPost = posts[indexPath.item]
            detailViewController.selectedPost = selectedPost
            
            navigationController?.pushViewController(detailViewController, animated: true)
        } else if collectionView == bannerCollectionView {
            let webViewController = WebViewController()
            if indexPath.item < bannerURL.count {
                if let url = URL(string: bannerURL[indexPath.item]) {
                    webViewController.url = url
                    navigationController?.pushViewController(webViewController, animated: true)
                }
            }
        }
    }
}
