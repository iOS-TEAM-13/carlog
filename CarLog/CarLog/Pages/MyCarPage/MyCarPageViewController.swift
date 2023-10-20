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
    
    private let dummy = CarParts(engineOil: PartsInfo(currentTime: "6개월 전", fixHistory: [FixHistory(changedDate: Date(), changedType: .isFixedParts), FixHistory(changedDate: Date(), changedType: .isFixedParts)]), missionOil: PartsInfo(currentTime: "1개월 전", fixHistory: []), brakeOil: PartsInfo(currentTime: "6개월 전", fixHistory: []), brakePad: PartsInfo(currentTime: "1년 전", fixHistory: []), tire: PartsInfo(currentTime: "6개월 전", fixHistory: []), tireRotation: PartsInfo(currentTime: "2년 전", fixHistory: []), fuelFilter: PartsInfo(currentTime: "6개월 전", fixHistory: []), wiper: PartsInfo(currentTime: "3년 전", fixHistory: []), airconFilter: PartsInfo(currentTime: "6개월 전", fixHistory: []), insurance: PartsInfo(currentTime: "6개월 전", fixHistory: []), userEmail: "")
    
    private var totalParts: [(String, PartsInfo)] = []
    
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tire"), UIImage(named: "tireRotation"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    
    private let menuTitle = ["엔진 오일", "미션 오일", "브레이크 오일", "브레이크 패드", "타이어", "로테이션", "연료 필터", "와이퍼", "에어컨 필터", "보험"]
    
    private let engToKor: [String:String] = ["engineOil" : "엔진 오일", "missionOil" : "미션 오일", "brakeOil" : "브레이크 오일", "brakePad" : "브레이크 패드", "tire" : "타이어 교체", "tireRotation" : "타이어 로테이션", "fuelFilter" : "연료 필터", "wiper" : "와이퍼 블레이드", "airconFilter" : "에어컨 필터", "insurance" : "보험"]
    
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
        
        //지훈
        //        FirestoreService.firestoreService.saveUsers(
        //            user: User(userId: "abc", email: "hhn0212@naver.com", password: "Rlawlgns1!",
        //            car: Car(number: "00서 0000", maker: "기아", name: "K5", oilType: "휘발유", nickName: "붕붕", totalDistance: 170,
        //            carInfo: CarInfo(engineOil: "3개월 전", missionOil: "3개월 전", brakeOil: "3개월 전", brakePad: "3개월 전", tire: "3개월 전",tireRotation: "3개월 전", fuelFilter: "3개월 전", wiper: "3개월 전", airconFilter: "3개월 전", insurance: "3개월 전"),
        //                     driving: [Driving(timeStamp: "2023.10.15", departDistance: 170, arriveDistance: 180, driveDistance: 10)], fueling: [nil]), post: nil)) { error in }
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
        mirror.children.forEach {
            if($0.label! != "userEmail") {
                totalParts.append((engToKor[$0.label!]!, PartsInfo(currentTime: ($0.value as! PartsInfo).currentTime, fixHistory: ($0.value as! PartsInfo).fixHistory)))
            }
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
        if let icon = menuIcon[indexPath.row] {
            let title = totalParts[indexPath.row].0
            let firstInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row].1.currentTimeToMonth!)).toString()
            let secondInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row].1.currentTimeToMonth)!, type: title).toString()
            cell.bind(title: title, interval: "\(firstInterval) ~ \(secondInterval)", icon: icon)
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCarDetailPageViewController()
        vc.dummyMenu = totalParts[indexPath.row]
        vc.dummyIcon = menuIcon[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 100)
    }
}
