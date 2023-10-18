import SnapKit
import SwiftUI
import UIKit

class MyCarPageViewController: UIViewController {
    
    //MARK: Properties
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var myCarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.dataSource = self
        view.delegate = self
        view.register(MyCarCollectionViewCell.self, forCellWithReuseIdentifier: MyCarCollectionViewCell.identifier)
        return view
    }()
    
    private let dummy = CarInfo(engineOil: "6개월", missionOil: "3개월", brakeOil: "3개월", brakePad: "1년", tire: "1개월", tireRotation: "2년", fuelFilter: "3년", wiper: "3개월", airconFilter: "6개월", insurance: "1개월")
    
    // MARK: Dummy
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tire"), UIImage(named: "tireRotation"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    
    private let menuTitle = ["엔진 오일", "미션 오일", "브레이크 오일", "브레이크 패드", "타이어", "로테이션", "연료 필터", "와이퍼", "에어컨 필터", "보험"]
    
    private var dummyData = [Menu]()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        
        createDummy()
        setupUI()
        checkFirst()
        
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
    private func setupUI() {
        view.addSubview(myCarCollectionView)
        
        myCarCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func checkFirst() {
        let userDefaults = UserDefaults.standard
        guard userDefaults.string(forKey: "isFirst") != nil else { userDefaults.set("false", forKey: "isFirst")
            let vc = MyCarCheckViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
    
    private func createDummy() {
        let mirror = Mirror(reflecting: dummy)
        let temp = mirror.children.compactMap{$0.value as? String}
        for i in 0...9 {
            dummyData.append(Menu(title: menuTitle[i], interval: temp[i], icon: menuIcon[i]!))
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
        cell.layer.cornerRadius = 20
        cell.bind(text: dummyData[indexPath.row].title , interval: dummyData[indexPath.row].interval, icon: dummyData[indexPath.row].icon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCarDetailPageViewController()
        vc.dummyMenu = dummyData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 100)
    }
}
