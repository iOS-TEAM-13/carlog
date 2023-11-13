import UIKit
import EasyTipView

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
    
    private let tooltipList = [("6개월", "3"), ("2년", "6"), ("2년", "6"), ("1년", "3"), ("1년", "3"), ("3년", "12"), ("1년", "3"), ("1년", "3"), ("1년", "3"), ("1년", "3")]

    var firstInterval = ""
    var secondInterval = ""
    var progress = 0.0
    
    var preferences = EasyTipView.Preferences()
    
    private var currentTooltip: EasyTipView?
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationItem.backBarButtonItem = backButton
        
        setupUI()
        setTooltip()
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
    
    private func setTooltip() {
        preferences.drawing.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .regular)
        preferences.drawing.foregroundColor = .black
        preferences.drawing.backgroundColor = .buttonSkyBlueColor
        preferences.animating.dismissOnTap = true
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.any
        EasyTipView.globalPreferences = preferences
    }
}

// MARK: Extension

extension MyCarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carParts.parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarCollectionViewCell.identifier, for: indexPath) as? MyCarCollectionViewCell else { return UICollectionViewCell() }
        let item = carParts.parts[indexPath.row]
        if let icon = menuIcon[indexPath.row], let start = item.startTime, let end = item.endTime {
            progress = Util.util.calculatorProgress(firstInterval: start, secondInterval: end)
            cell.tooltipTapped = {
                self.currentTooltip?.dismiss()
                let tooltip = EasyTipView(text: "\(item.name.rawValue) 권장 교체 기간: \(self.tooltipList[indexPath.row].0) \n 교체가 \(self.tooltipList[indexPath.row].1)개월 남으면 알림을 보내드려요!", preferences: self.preferences, delegate: self)
                tooltip.show(forView: cell.tooltipIcon)
                cell.isUserInteractionEnabled = false
                self.currentTooltip = tooltip
                }
            cell.bind(title: item.name.rawValue, interval: "\(start.toString()) ~ \(end.toString())", icon: icon, progress: progress)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentTooltip?.dismiss()
        let vc = MyCarDetailPageViewController()
        guard let start = carParts.parts[indexPath.row].startTime, let end = carParts.parts[indexPath.row].endTime else { return }
            progress = Util.util.calculatorProgress(firstInterval: start, secondInterval: end)
            vc.selectedParts = carParts.parts[indexPath.row]
            for i in 0 ... vc.saveData.parts.count - 1 {
                if vc.saveData.parts[i].name == carParts.parts[indexPath.row].name {
                    vc.saveData.parts[i] = carParts.parts[indexPath.row]
                }
        }
        vc.selectedProgress = progress
        vc.selectedIcon = menuIcon[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 100)
    }
}

extension MyCarPageViewController: EasyTipViewDelegate {
    func easyTipViewDidTap(_ tipView: EasyTipView) {
        print("@@@ tap")
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        myCarCollectionView.visibleCells.forEach { $0.isUserInteractionEnabled = true }
        print("@@@ dismiss")
    }
    
    
}
