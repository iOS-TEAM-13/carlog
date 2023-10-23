import FirebaseAuth
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
    
    private var carParts = Constants.carParts

//    private var totalParts: [(String, Any)] = [("엔진 오일", PartsInfo(currentTime: "3년 전", fixHistory: [(FixHistory(changedDate: Date(), changedType: (ChangedType.isFixedParts))), (FixHistory(changedDate: Date(), changedType: ChangedType.isFixedParts))])), ("미션 오일", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("브레이크 오일", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("브레이크 패드", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("타이어 로테이션", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("타이어 교체", PartsInfo(currentTime: ("3년 전"), fixHistory: [])), ("연료 필터", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("와이퍼 블레이드", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("에어컨 필터", PartsInfo(currentTime: "3년 전", fixHistory: [])), ("보험", InsuranceInfo(currentTime: "3", fixHistory: []))]
    
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tireRotation"), UIImage(named: "tire"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    
    private let engToKor: [String:String] = ["engineOil" : "엔진 오일", "missionOil" : "미션 오일", "brakeOil" : "브레이크 오일", "brakePad" : "브레이크 패드", "tireRotation" : "타이어 로테이션", "tire" : "타이어 교체", "fuelFilter" : "연료 필터", "wiper" : "와이퍼 블레이드", "airconFilter" : "에어컨 필터", "insurance" : "보험"]
    
    var firstInterval = ""
    var secondInterval = ""
    var progress = 0.0
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        
        setupUI()
        checkFirst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
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
        guard userDefaults.string(forKey: Auth.auth().currentUser?.email ?? "") != nil else { userDefaults.set("false", forKey: Auth.auth().currentUser?.email ?? "")
            let vc = MyCarCheckViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
    
//    private func createDummy() {
//        totalParts.removeAll()
//        let mirror = Mirror(reflecting: carParts)
//        mirror.children.forEach {
//            if($0.label! == "insurance") {
//                totalParts.append((engToKor[$0.label!]!, InsuranceInfo(currentTime: ($0.value as! InsuranceInfo).currentTime, fixHistory: ($0.value as! InsuranceInfo).fixHistory)))
//            } else if($0.label! == "userEmail") { } else {
//                totalParts.append((engToKor[$0.label!]!, PartsInfo(currentTime: ($0.value as! PartsInfo).currentTime, fixHistory: ($0.value as! PartsInfo).fixHistory)))
//            }
//        }
//    }
    
    private func loadData() {
        FirestoreService.firestoreService.loadCarPart() { data in
            DispatchQueue.main.async {
                if let data = data {
                    self.carParts = data
                    self.myCarCollectionView.reloadData()
                }
            }
        }
    }
    
    private func calculatorProgress(firstInterval: String, secondInterval: String) -> Double {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let first = firstInterval.intervalToDate() else { return 0.0 }
        guard let second = secondInterval.intervalToDate() else { return 0.0 }

        let totalProgress = calendar.dateComponents([.day], from: first, to: second)
        let currentProgress = calendar.dateComponents([.day], from: first, to: currentDate)
        guard let firstDays = totalProgress.day else { return 0.0 }
        guard let secoundDays = currentProgress.day else { return 0.0 }
        
        return Double(secoundDays) / Double(firstDays)
    }
    
    private func calculatorProgress(firstInsurance: String, secondInsurance: String) -> Double {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let first = firstInsurance.intervalToDate() else { return 0.0 }
        guard let second = secondInsurance.intervalToDate() else { return 0.0 }

        let totalProgress = calendar.dateComponents([.day], from: first, to: second)
        let currentProgress = calendar.dateComponents([.day], from: first, to: currentDate)

        guard let firstDays = totalProgress.day else { return 0.0 }
        guard let secoundDays = currentProgress.day else { return 0.0 }
        return Double(secoundDays) / Double(firstDays)
    }
}

extension MyCarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carParts.parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarCollectionViewCell.identifier, for: indexPath) as? MyCarCollectionViewCell else { return UICollectionViewCell() }
//        if let icon = menuIcon[indexPath.row] {
//            let title = totalParts[indexPath.row].0
//            if indexPath.row != 9 {
//                firstInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth!).toString()
//                secondInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth ?? 0, type: title).toString()
//                progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
//            } else {
//                firstInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).0.toString()
//                secondInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).1.toString()
//                progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
//            }
//            cell.bind(title: title, interval: "\(firstInterval) ~ \(secondInterval)", icon: icon, progress: progress)
//        }
        if let icon = menuIcon[indexPath.row] {
            if carParts.parts[indexPath.row].name != .insurance {
                firstInterval = Util.util.toInterval(seletedDate: carParts.parts[indexPath.row].currentTimeToMonth!).toString()
                secondInterval = Util.util.toInterval(seletedDate: carParts.parts[indexPath.row].currentTimeToMonth ?? 0, type: carParts.parts[indexPath.row].name).toString()
                progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
            } else {
                firstInterval = Util.util.toInterval(seletedInsuranceDate: Int(carParts.parts[indexPath.row].currentTime!) ?? 0).0.toString()
                secondInterval = Util.util.toInterval(seletedInsuranceDate: Int((carParts.parts[indexPath.row]).currentTime!) ?? 0).1.toString()
                progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
            }
            cell.bind(title: carParts.parts[indexPath.row].name.rawValue, interval: "\(firstInterval) ~ \(secondInterval)", icon: icon, progress: progress)
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = MyCarDetailPageViewController()
//        let title = totalParts[indexPath.row].0
//        if indexPath.row != 9 {
//            vc.selectedParts = totalParts[indexPath.row] as? (String, PartsInfo)
//            firstInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth!).toString()
//            secondInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth ?? 0, type: title).toString()
//            progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
//        } else {
//            vc.selectedInsurance = totalParts[indexPath.row] as? (String, InsuranceInfo)
//            firstInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).0.toString()
//            secondInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).1.toString()
//            progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
//        }
//        vc.selectedProgress = progress
//        vc.selectedInterval = "\(firstInterval) ~ \(secondInterval)"
//        vc.selectedIcon = menuIcon[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
        let vc = MyCarDetailPageViewController()
        if carParts.parts[indexPath.row].name != .insurance {
            firstInterval = Util.util.toInterval(seletedDate: (carParts.parts[indexPath.row]).currentTimeToMonth!).toString()
            secondInterval = Util.util.toInterval(seletedDate: (carParts.parts[indexPath.row]).currentTimeToMonth ?? 0, type: carParts.parts[indexPath.row].name).toString()
            progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
        } else {
            firstInterval = Util.util.toInterval(seletedInsuranceDate: Int(carParts.parts[indexPath.row].currentTime!) ?? 0).0.toString()
            secondInterval = Util.util.toInterval(seletedInsuranceDate: Int(carParts.parts[indexPath.row].currentTime!) ?? 0).1.toString()
            progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
        }
        vc.selectedParts = carParts.parts[indexPath.row]
        vc.selectedProgress = progress
        vc.selectedInterval = "\(firstInterval) ~ \(secondInterval)"
        vc.selectedIcon = menuIcon[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 100)
    }
}
