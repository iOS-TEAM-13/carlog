import UIKit

import SnapKit

class HistoryPageViewController: UIViewController {
    
    //주행, 주유 빈 배열
    var drivingDummy: [Driving] = []
    var fuelingDummy: [Fueling] = []
    
    //히스토리 페이지 상단 주행, 주유 collectionView 나눠서 보여지게하는 segmented
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = .mainNavyColor
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    //주행 히스토리
    lazy var drivingCollectionView: DrivingView = {
        let drivingCollectionView = DrivingView()
        drivingCollectionView.drivingCollectionView.dataSource = self
        drivingCollectionView.drivingCollectionView.delegate = self
        drivingCollectionView.drivingCollectionView.register(DrivingCollectionViewCell.self, forCellWithReuseIdentifier: DrivingCollectionViewCell.identifier)
        drivingCollectionView.drivingCollectionView.backgroundColor = .backgroundCoustomColor
        return drivingCollectionView
    }()
    
    //주유 히스토리
    lazy var fuelingCollectionView: FuelingView = {
        let fuelingCollectionView = FuelingView()
        fuelingCollectionView.fuelingCollectionView.dataSource = self
        fuelingCollectionView.fuelingCollectionView.delegate = self
        fuelingCollectionView.fuelingCollectionView.register(FuelingCollectionViewCell.self, forCellWithReuseIdentifier: FuelingCollectionViewCell.identifier)
        fuelingCollectionView.fuelingCollectionView.backgroundColor = .backgroundCoustomColor
        return fuelingCollectionView
    }()
    
    //segmented 전환
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.drivingCollectionView.isHidden = shouldHideFirstView
            self.fuelingCollectionView.isHidden = !self.drivingCollectionView.isHidden
        }
    }
    
    //두개의 addPage로 이동하기 위한 플로팅 버튼
    lazy var floatingButtonStackView: FloatingButtonStackView = {
        let floatingButtonStackView = FloatingButtonStackView()
        floatingButtonStackView.navigationController = self.navigationController
        return floatingButtonStackView
    }()
    
    //로딩 인디케이터
    var ac: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        
        setupUI()
        didChangeValue(segment: segmentedControl)
        buttonActions()
        
        // indicator 추가
        ac = UIActivityIndicatorView(style: .medium)
        ac.center = view.center
        view.addSubview(ac)
        ac.startAnimating()
        
        // NotificationCenter addDriving 연결하기
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewDrivingRecordAdded(_:)), name: .newDrivingRecordAdded, object: nil)
        
        // NotificationCenter addFueling 연결하기
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewFuelingRecordAdded(_:)), name: .newFuelingRecordAdded, object: nil)
    }
    
    //newDriving 배열 맨 위에 저장하기
    @objc func handleNewDrivingRecordAdded(_ notification: Notification) {
        if let newDriving = notification.object as? Driving {
            //중복이 아니면 로드하고 저장하고 리로드하기
            if !drivingDummy.contains(where: { $0.id == newDriving.id }) {
                loadDrivingData()
                drivingDummy.insert(newDriving, at: 0)
                drivingCollectionView.drivingCollectionView.reloadData()
            }
        }
    }

    //newFueling 배열 맨 위에 저장하기
    @objc func handleNewFuelingRecordAdded(_ notification: Notification) {
        if let newFueling = notification.object as? Fueling {
            //중복이 아니면 로드하고 저장하고 리로드하기
            if !fuelingDummy.contains(where: { $0.id == newFueling.id }) {
                loadFuelingData()
                fuelingDummy.insert(newFueling, at: 0)
                fuelingCollectionView.fuelingCollectionView.reloadData()
            }
        }
    }
    
    //Notification제거?
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        loadDrivingData()
        loadFuelingData()
    }

    // MARK: - HistoryPageView UI 설정
    func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(drivingCollectionView)
        view.addSubview(fuelingCollectionView)
        view.addSubview(floatingButtonStackView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin * 4)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 4)
            make.height.equalTo(60)
        }
        
        drivingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        fuelingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        floatingButtonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
        }
    }
    
    // MARK: - 히스토리페이지 플로팅퍼튼 클릭 이벤트
    func buttonActions() {
        floatingButtonStackView.floatingButton.addAction(UIAction(handler: { _ in
            self.isActive.toggle()
        }), for: .touchUpInside)
        
        floatingButtonStackView.fuelingButton.addAction(UIAction(handler: { _ in
            let addFuelingViewController = AddFuelingViewController()
            let navigationController = UINavigationController(rootViewController: addFuelingViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
            self.segmentedControl.selectedSegmentIndex = 0
            self.didChangeValue(segment: self.segmentedControl)
            self.isActive.toggle()
        }), for: .touchUpInside)
        
        floatingButtonStackView.drivingButton.addAction(UIAction(handler: { _ in
            let addDrivingViewController = AddDrivingViewController()
            let navigationController = UINavigationController(rootViewController: addDrivingViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
            self.segmentedControl.selectedSegmentIndex = 0
            self.didChangeValue(segment: self.segmentedControl)
            self.isActive.toggle()
        }), for: .touchUpInside)
    }
    
    //
    private var animation: UIViewPropertyAnimator?
    
    //
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
    //
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    //
    private func popButtons() {
        if isActive {
            floatingButtonStackView.fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.fuelingButton.layer.transform = CATransform3DIdentity
                floatingButtonStackView.fuelingButton.alpha = 1.0
            })
            
            floatingButtonStackView.drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.drivingButton.layer.transform = CATransform3DIdentity
                floatingButtonStackView.drivingButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                floatingButtonStackView.fuelingButton.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                floatingButtonStackView.drivingButton.alpha = 0.0
            }
        }
    }
    
    //
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButtonStackView.floatingButton.layer.add(animation, forKey: nil)
    }
    
    //파베 주행 데이터 로드
    func loadDrivingData() {
        FirestoreService.firestoreService.loadDriving { result in
            if let drivings = result {
                self.drivingDummy = drivings.sorted(by: { $0.timeStamp?.toDate() ?? Date() < $1.timeStamp?.toDate() ?? Date() })
                DispatchQueue.main.async {
                    self.drivingCollectionView.drivingCollectionView.reloadData()
                    self.ac.stopAnimating()
                    self.ac.isHidden = true
                    
                    if self.drivingDummy.count > 0 {
                        self.drivingCollectionView.noDataLabel.isHidden = true
                    } else {
                        self.drivingCollectionView.noDataLabel.isHidden = false
                    }
                }
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    //파베 주유 데이터 로드
    func loadFuelingData() {
        FirestoreService.firestoreService.loadFueling { result in
            if let fuelings = result {
                self.fuelingDummy = fuelings.sorted(by: { $0.timeStamp?.toDate() ?? Date() < $1.timeStamp?.toDate() ?? Date() })
                DispatchQueue.main.async {
                    self.fuelingCollectionView.fuelingCollectionView.reloadData()
                    self.ac.stopAnimating()
                    self.ac.isHidden = true
                    
                    if self.fuelingDummy.count > 0 {
                        self.fuelingCollectionView.noDataLabel.isHidden = true
                    } else {
                        self.fuelingCollectionView.noDataLabel.isHidden = false
                    }
                }
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
}

extension HistoryPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == drivingCollectionView.drivingCollectionView {
            return drivingDummy.count
        } else {
            return fuelingDummy.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == drivingCollectionView.drivingCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrivingCollectionViewCell.identifier, for: indexPath) as? DrivingCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = Constants.cornerRadius * 2
            
            cell.writeDateLabel.text = drivingDummy[indexPath.row].timeStamp ?? ""
            cell.drivingPurposeLabel.text = drivingDummy[indexPath.row].drivingPurpose ?? ""
            cell.driveDistenceLabel.text = String("\(drivingDummy[indexPath.row].driveDistance ?? 0)km")
            cell.arriveTotalDistenceLabel.text = String("\(drivingDummy[indexPath.row].arriveDistance ?? 0)km")
            
            return cell
            
        } else if collectionView == fuelingCollectionView.fuelingCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuelingCollectionViewCell.identifier, for: indexPath) as? FuelingCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = Constants.cornerRadius * 2
            
            cell.writeDateLabel.text = fuelingDummy[indexPath.row].timeStamp ?? ""
            cell.priceLabel.text = String("\(fuelingDummy[indexPath.row].price ?? 0)원")
            cell.totalPriceLabel.text = String("\(fuelingDummy[indexPath.row].totalPrice ?? 0)원")
            cell.countLabel.text = String("\(fuelingDummy[indexPath.row].count ?? "")L")
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - Constants.horizontalMargin * 4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == drivingCollectionView.drivingCollectionView {
            let driveDetailViewController = DriveDetailViewController()
            driveDetailViewController.drivingData = drivingDummy[indexPath.row]
            navigationController?.pushViewController(driveDetailViewController, animated: true)
            
        } else if collectionView == fuelingCollectionView.fuelingCollectionView {
            let fuelingDetailViewController = FuelingDetailViewController()
            fuelingDetailViewController.fuelingData = fuelingDummy[indexPath.row]
            navigationController?.pushViewController(fuelingDetailViewController, animated: true)
        }
    }
}
