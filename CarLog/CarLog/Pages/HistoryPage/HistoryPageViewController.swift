import SnapKit
import UIKit

class HistoryPageViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = .primaryColor
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Constants.fontJua20 ?? UIFont(), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Constants.fontJua20 ?? UIFont(), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    lazy var drivingCollectionView: DrivingView = {
        let drivingCollectionView = DrivingView()
        return drivingCollectionView
    }()
    
    lazy var fuelingCollectionView: FuelingView = {
        let fuelingCollectionView = FuelingView()
        return fuelingCollectionView
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.drivingCollectionView.isHidden = shouldHideFirstView
            self.fuelingCollectionView.isHidden = !self.drivingCollectionView.isHidden
        }
    }
    
    lazy var floatingButtonStackView: FloatingButtonStackView = {
        let floatingButtonStackView = FloatingButtonStackView()
        floatingButtonStackView.navigationController = self.navigationController
        return floatingButtonStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        
        self.didChangeValue(segment: self.segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(drivingCollectionView)
        view.addSubview(fuelingCollectionView)
        view.addSubview(floatingButtonStackView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
        
        drivingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        fuelingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        floatingButtonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
    }
    
    
}
