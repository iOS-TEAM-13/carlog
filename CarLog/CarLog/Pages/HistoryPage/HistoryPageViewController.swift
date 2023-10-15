import SnapKit
import UIKit

class HistoryPageViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var drivingTableView: DrivingView = {
        let drivingTableView = DrivingView()
        return drivingTableView
    }()
    
    lazy var fuelingTableView: FuelingView = {
        let fuelingTableView = FuelingView()
        return fuelingTableView
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.drivingTableView.isHidden = shouldHideFirstView
            self.fuelingTableView.isHidden = !self.drivingTableView.isHidden
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
        view.addSubview(drivingTableView)
        view.addSubview(fuelingTableView)
        view.addSubview(floatingButtonStackView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(40)
        }
        
        drivingTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        fuelingTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        floatingButtonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }

    }
    
    
}
