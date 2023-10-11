import UIKit
import SnapKit

class HistoryPageViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var drivingListView: UIView = {
        let drivingListView = UIView()
        drivingListView.backgroundColor = .gray
        return drivingListView
    }()
    
    lazy var fuelingListView: UIView = {
        let fuelingListView = UIView()
        fuelingListView.backgroundColor = .orange
        return fuelingListView
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.drivingListView.isHidden = shouldHideFirstView
            self.fuelingListView.isHidden = !self.drivingListView.isHidden
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(drivingListView)
        view.addSubview(fuelingListView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.verticalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-(Constants.verticalMargin))
            make.height.equalTo(40)
        }
        
        drivingListView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(segmentedControl.snp.leading)
            make.trailing.equalTo(segmentedControl.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        fuelingListView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(segmentedControl.snp.leading)
            make.trailing.equalTo(segmentedControl.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        
        self.didChangeValue(segment: self.segmentedControl)
    }
}
