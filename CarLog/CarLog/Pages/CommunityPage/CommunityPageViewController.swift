import UIKit
import SnapKit

class CommunityPageViewController: UIViewController {
    
    private var items: [String] = [] //커뮤니티 셀 배열
    
    private var banners: [String] = ["a", "b", "c"] //배너 셀 배열
    
    private var timer: Timer? //배너 일정 시간 지날때 자동으로 바뀜
    
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
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 80)  // 배너의 너비를 뷰의 너비로 설정
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
        self.view.backgroundColor = UIColor.white
        
        communityColletionView.register(CommunityPageCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityCell")
        communityColletionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        
        setupUI()
        startBannerTimer()
    }
    
    func setupUI() {
        view.addSubview(communityColletionView)
        view.addSubview(editFloatingButton)
        view.addSubview(bannerCollectionView)
        
            bannerCollectionView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.left.right.equalToSuperview()
                make.height.equalTo(80) // 원하는 높이 설정
            }
        
        communityColletionView.snp.makeConstraints { make in
                // make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(20)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
           }
        
        editFloatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
          make.rightMargin.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-102)
        }
    }
    //배너 컬렉션 뷰 셀 전환 속도 조정
    private func startBannerTimer() {
          timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextBanner), userInfo: nil, repeats: true)
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
        
    //    items.append(“New Item”)
    //    print(“새 항목 추가“)
    //    communityColletionView.reloadData()
    //    :압정:네비게이션 화면 전환 기능
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
    //셀 클릭 시 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == communityColletionView {
            let detailViewController = CommunityDetailPageViewController() // DetailPageViewController는 상세 페이지를 나타내는 뷰 컨트롤러입니다.
            // 필요하다면 detailViewController에 데이터 전달
            // 예: detailViewController.item = items[indexPath.item]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
}
