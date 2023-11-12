import UIKit

import FirebaseAuth
import SnapKit
import SwiftUI

class MyCarPageViewController: UIViewController {
    // MARK: Properties

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var myCarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .backgroundCoustomColor
        view.clipsToBounds = true
        view.dataSource = self
        view.delegate = self
        view.register(MyCarCollectionViewCell.self, forCellWithReuseIdentifier: MyCarCollectionViewCell.identifier)
        return view
    }()
    
    let backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: nil, action: nil)
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    private var carParts = Constants.carParts
    
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tireRotation"), UIImage(named: "tire"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    
    private let engToKor: [String: String] = ["engineOil": "엔진 오일", "missionOil": "미션 오일", "brakeOil": "브레이크 오일", "brakePad": "브레이크 패드", "tireRotation": "타이어 로테이션", "tire": "타이어 교체", "fuelFilter": "연료 필터", "wiper": "와이퍼 블레이드", "airconFilter": "에어컨 필터", "insurance": "보험"]
    
    var firstInterval = ""
    var secondInterval = ""
    var progress = 0.0
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationItem.backBarButtonItem = backButton
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        loadData()
        NotificationService.service.setAuthorization() {
            DispatchQueue.main.async {
                self.moveToSettingAlert(reason: "알림 권한 요철 거부됨", discription: "설정에서 권한을 허용해주세요.")
            }
        }
    }
    
    // MARK: Method

    private func setupUI() {
        view.addSubview(myCarCollectionView)
        
        myCarCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func moveToSettingAlert(reason: String, discription: String) {
        let alert = UIAlertController(title: reason, message: discription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        cancle.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    
    private func checkFirst() {
        let userDefaults = UserDefaults.standard
        guard userDefaults.string(forKey: Constants.currentUser.userEmail ?? "") != nil else { userDefaults.set("false", forKey: Constants.currentUser.userEmail ?? "")
            let vc = MyCarCheckViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
    
    private func loadData() {
        FirestoreService.firestoreService.loadCarPart { data in
            if let data = data {
                self.carParts = data
                self.myCarCollectionView.reloadData()
            } else {
                let vc = MyCarCheckViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        if Auth.auth().currentUser?.email != Constants.currentUser.userEmail {
            FirestoreService.firestoreService.loadCar { result in
                if let car = result {
                    Constants.currentUser = car.first ?? Car(number: "", maker: "", name: "", oilType: "", nickName: "", totalDistance: 0, userEmail: "")
                } else {
                    print("데이터 로드 중 오류 발생")
                }
            }
        }
    }
}

// MARK: Extension

extension MyCarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carParts.parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarCollectionViewCell.identifier, for: indexPath) as? MyCarCollectionViewCell else { return UICollectionViewCell() }
        if let icon = menuIcon[indexPath.row] {
            if carParts.parts[indexPath.row].name != .insurance {
                if let timetoMonth = carParts.parts[indexPath.row].currentTimeToMonth {
                    firstInterval = Util.util.toInterval(seletedDate: timetoMonth).toString()
                    secondInterval = Util.util.toInterval(seletedDate: timetoMonth, type: carParts.parts[indexPath.row].name).toString()
                }
                progress = Util.util.calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
            } else {
                if let time = carParts.parts[indexPath.row].currentTime {
                    firstInterval = Util.util.toInterval(seletedInsuranceDate: Int(time) ?? 0).0.toString()
                    secondInterval = Util.util.toInterval(seletedInsuranceDate: Int(time) ?? 0).1.toString()
                }
                
                progress = Util.util.calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
            }
            cell.bind(title: carParts.parts[indexPath.row].name.rawValue, interval: "\(firstInterval) ~ \(secondInterval)", icon: icon, progress: progress)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MyCarDetailPageViewController()
        guard let timetoMonth = carParts.parts[indexPath.row].currentTimeToMonth else { return }
        guard let time = carParts.parts[indexPath.row].currentTime else { return }
        if carParts.parts[indexPath.row].name != .insurance {
            firstInterval = Util.util.toInterval(seletedDate: timetoMonth).toString()
            secondInterval = Util.util.toInterval(seletedDate: timetoMonth, type: carParts.parts[indexPath.row].name).toString()
            firstInterval = Util.util.toInterval(seletedDate: timetoMonth).toString()
            secondInterval = Util.util.toInterval(seletedDate: timetoMonth, type: carParts.parts[indexPath.row].name).toString()
            progress = Util.util.calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
        } else {
            firstInterval = Util.util.toInterval(seletedInsuranceDate: Int(time) ?? 0).0.toString()
            secondInterval = Util.util.toInterval(seletedInsuranceDate: Int(time) ?? 0).1.toString()
            progress = Util.util.calculatorProgress(firstInsurance: firstInterval, secondInsurance: secondInterval)
        }
        vc.selectedParts = carParts.parts[indexPath.row]
        for i in 0 ... vc.saveData.parts.count - 1 {
            if vc.saveData.parts[i].name == carParts.parts[indexPath.row].name {
                vc.saveData.parts[i] = carParts.parts[indexPath.row]
            }
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
