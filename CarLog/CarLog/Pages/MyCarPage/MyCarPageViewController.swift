import UIKit
import SnapKit
import SwiftUI

class MyCarPageViewController: UIViewController {
    
    //MARK: Properties
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //      layout.minimumLineSpacing = 8.0 // <- 셀 간격 설정
//        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private lazy var myCarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
//        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
//        view.contentInset = .zero
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.register(MyCarCollectionViewCell.self, forCellWithReuseIdentifier: MyCarCollectionViewCell.identifier)
        return view
    }()
    
    private let dummy = CarInfo(engineOil: "엔진 오일", missionOil: "미션 오일", brakeOil: "브레이크 오일", brakePad: "브레이크 패드", tire: "타이어", tireRotation: "로테이션", fuelFilter: "연료 필터", wiper: "와이퍼", airconFilter: "에어컨 필터", insurance: "보험")
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tire"), UIImage(named: "tireRotation"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        
        registerTableview()
        setupUI()
        
        
//        FirestoreService.firestoreService.saveComment(comment: Comment(id: "id5", content: "content5", userId: "userId5", userName: "userName")) { error in
//            print("###### comments: \(error)")
//        }
//
//        FirestoreService.firestoreService.loadComments() { result in
//            print("################# comments: \(result)")
//        }
//
//        FirestoreService.firestoreService.savePosts(post: Post(id: "id7", title: "title7", content: "content7", image: ["image1", "image2"], comment: [Comment(id: "id8", content: "content8", userId: "userId8", userName: "userName8"), Comment(id: "id9", content: "content9", userId: "userId9", userName: "userName9")])) { error in
//            print("###### posts:  \(error)")
//        }
//
//        FirestoreService.firestoreService.loadPosts() { result in
//            print("########## posts: \(result)")
//        }
    }
    
    //MARK: Method
    private func registerTableview() {
        myCarCollectionView.delegate = self
        myCarCollectionView.dataSource = self
    }
    
    private func setupUI() {
        view.addSubview(myCarCollectionView)
        
        myCarCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
    }
}

// SwiftUI를 활용한 미리보기
struct MyCarPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyCarPageVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct MyCarPageVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let myCarPageVC = MyCarPageViewController()
        return UINavigationController(rootViewController: myCarPageVC)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    typealias UIViewControllerType = UIViewController
}

extension MyCarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarCollectionViewCell.identifier, for: indexPath) as? MyCarCollectionViewCell else { return UICollectionViewCell() }
        let mirror = Mirror(reflecting: dummy)
        let temp = mirror.children.compactMap{$0.value as? String}[indexPath.row]
        if let icon = menuIcon[indexPath.row] {
            cell.bind(text: temp, period: "기간1", icon: icon)
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCarCheckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: 100)
    }
}
