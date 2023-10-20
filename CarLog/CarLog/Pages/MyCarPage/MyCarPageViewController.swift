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
    
    private let dummy = CarPart(engineOil: PartsInfo(currentTime: "3년 전", fixHistory: [FixHistory(changedDate: Date(), changedType: .isFixedParts), FixHistory(changedDate: Date(), changedType: .isFixedParts)]), missionOil: PartsInfo(currentTime: "3년 전", fixHistory: []), brakeOil: PartsInfo(currentTime: "3년 전", fixHistory: []), brakePad: PartsInfo(currentTime: "3년 전", fixHistory: []), tire: PartsInfo(currentTime: "3년 전", fixHistory: []), tireRotation: PartsInfo(currentTime: "3년 전", fixHistory: []), fuelFilter: PartsInfo(currentTime: "3년 전", fixHistory: []), wiper: PartsInfo(currentTime: "3년 전", fixHistory: []), airconFilter: PartsInfo(currentTime: "3년 전", fixHistory: []), insurance: InsuranceInfo(currentTime: "3", fixHistory: []), userEmail: "")

    private var totalParts: [(String, Any)] = []
    
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tire"), UIImage(named: "tireRotation"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    
    private let menuTitle = ["엔진 오일", "미션 오일", "브레이크 오일", "브레이크 패드", "타이어", "로테이션", "연료 필터", "와이퍼", "에어컨 필터", "보험"]
    
    private let engToKor: [String:String] = ["engineOil" : "엔진 오일", "missionOil" : "미션 오일", "brakeOil" : "브레이크 오일", "brakePad" : "브레이크 패드", "tire" : "타이어 교체", "tireRotation" : "타이어 로테이션", "fuelFilter" : "연료 필터", "wiper" : "와이퍼 블레이드", "airconFilter" : "에어컨 필터", "insurance" : "보험"]
    
    var firstInterval = ""
    var secondInterval = ""
    var progress = 0.0
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        createDummy()
        setupUI()
        checkFirst()
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
            if($0.label! == "insurance") {
                print($0.label!)
                totalParts.append((engToKor[$0.label!]!, InsuranceInfo(currentTime: ($0.value as! InsuranceInfo).currentTime, fixHistory: ($0.value as! InsuranceInfo).fixHistory)))
            } else if($0.label! == "userEmail") { } else {
                totalParts.append((engToKor[$0.label!]!, PartsInfo(currentTime: ($0.value as! PartsInfo).currentTime, fixHistory: ($0.value as! PartsInfo).fixHistory)))
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
        return Double(firstDays) / Double(secoundDays)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarCollectionViewCell.identifier, for: indexPath) as? MyCarCollectionViewCell else { return UICollectionViewCell() }
        if let icon = menuIcon[indexPath.row] {
            let title = totalParts[indexPath.row].0
            if indexPath.row != 9 {
                print(totalParts)
                firstInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth!).toString()
                secondInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth ?? 0, type: title).toString()
                progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
            } else {
                firstInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).0.toString()
                secondInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).1.toString()
                progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
            }
            cell.bind(title: title, interval: "\(firstInterval) ~ \(secondInterval)", icon: icon, progress: progress)
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCarDetailPageViewController()
        let title = totalParts[indexPath.row].0
        if indexPath.row != 9 {
            vc.selectedParts = totalParts[indexPath.row] as? (String, PartsInfo)
            firstInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth!).toString()
            secondInterval = Util.util.toInterval(seletedDate: (totalParts[indexPath.row] as! (String, PartsInfo)).1.currentTimeToMonth ?? 0, type: title).toString()
            progress = calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
        } else {
            vc.selectedInsurance = totalParts[indexPath.row] as? (String, InsuranceInfo)
            firstInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).0.toString()
            secondInterval = Util.util.toInterval(seletedInsuranceDate: Int((totalParts[indexPath.row] as! (String, InsuranceInfo)).1.currentTime!) ?? 0).1.toString()
            progress = calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
        }
        vc.selectedProgress = progress
        vc.selectedInterval = "\(firstInterval) ~ \(secondInterval)"
        vc.selectedIcon = menuIcon[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 100)
    }
}
