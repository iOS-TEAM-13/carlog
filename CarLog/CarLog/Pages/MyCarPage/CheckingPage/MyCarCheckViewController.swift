//
//  MyCarCheckViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class MyCarCheckViewController: UIViewController {
    // MARK: Properties
    private let engineOilView = PageViewController(view: CheckingView(title: "엔진 오일은 언제 교체하셨나요?", firstButton: "6개월 전", secondButton: "3개월 전", thirdbutton: "1개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .engineOil)
    private let missionOilView = PageViewController(view: CheckingView(title: "미션 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .missionOil)
    private let brakeOilView = PageViewController(view: CheckingView(title: "브레이크 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .brakeOil)
    private let brakePadView = PageViewController(view: CheckingView(title: "브레이크 패드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .brakePad)
    private let tireRotationView = PageViewController(view: CheckingView(title: "마지막 타이어 로테이션은 언제였나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .tireRotation)
    private let tireView = PageViewController(view: CheckingView(title: "타이어는 언제 교체하셨나요?", firstButton: "3년 전", secondButton: "2년 전", thirdbutton: "1년 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .tire)
    private let fuelFilterView = PageViewController(view: CheckingView(title: "연료 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .fuelFilter)
    private let wiperBladeView = PageViewController(view: CheckingView(title: "와이퍼 블레이드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .wiperBlade)
    private let airconFilterView = PageViewController(view: CheckingView(title: "에어컨 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .airconFilter)
    private let insuranceView = PageViewController(view:  CheckingView(title: "보험 가입 시기는 언제쯤인가요?", firstButton: "", secondButton: "", thirdbutton: "", fourthButton: "", fifthButton: ""), checkingView: .insurance)
    
    lazy var dataViewControllers: [UIViewController] = {
        return [engineOilView, missionOilView, brakeOilView, brakePadView, tireRotationView, tireView, fuelFilterView, wiperBladeView, airconFilterView, insuranceView]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    lazy private var addButton = UIBarButtonItem(title: "완료", primaryAction: UIAction(handler: { _ in
        FirestoreService.firestoreService.saveCarPart(carPart: Constants.carParts) { error in
            print("데이터 저장 성공")
            self.dismiss(animated: true, completion: nil)
        }
    }))
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tabBarController?.tabBar.isHidden = true
        
        setupUI()
        setupDelegate()
        setPageViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(completedCheckingView), name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    // MARK: Method
    private func setupUI() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        pageViewController.didMove(toParent: self)
    }
    
    private func setPageViewController() {
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    // MARK: objc
    @objc private func completedCheckingView() {
        if Constants.carParts.parts.filter({ $0.currentTime == nil }).count == 0 {
            navigationItem.rightBarButtonItem = addButton
        }
    }
}

extension MyCarCheckViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        completedCheckingView()
    }
}
