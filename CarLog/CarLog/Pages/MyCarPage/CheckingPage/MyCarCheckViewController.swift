//
//  MyCarCheckViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import UIKit

import FirebaseAuth
import Lottie
import SnapKit

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
    private let insuranceView = PageViewController(view: CheckingView(title: "보험 가입 시기는 언제쯤인가요?", firstButton: "", secondButton: "", thirdbutton: "", fourthButton: "", fifthButton: ""), checkingView: .insurance)
    
    var checkCountLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "0/10", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold), alignment: .center)
       return label
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        [engineOilView, missionOilView, brakeOilView, brakePadView, tireRotationView, tireView, fuelFilterView, wiperBladeView, airconFilterView, insuranceView]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    private lazy var addButton = UIBarButtonItem(title: "완료", primaryAction: UIAction(handler: { [weak self] _ in
        Constants.carParts.userEmail = Auth.auth().currentUser?.email
        FirestoreService.firestoreService.saveCarPart(carPart: Constants.carParts) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }))
    
    let animationView: LottieAnimationView = .init(name: "slideAnimation")
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
        view.addSubview(checkCountLabel)
        view.addSubview(animationView)

        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        pageViewController.didMove(toParent: self)

        checkCountLabel.snp.makeConstraints {
            $0.top.equalTo(pageViewController.view.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
        }
        
        animationView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        animationView.loopMode = .playOnce
        animationView.play { _ in
            self.animationView.isHidden = true
            self.animationView.removeFromSuperview()
        }
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
        let count = Constants.carParts.parts.filter({ $0.currentTime != nil }).count
        if count == 10 {
            navigationItem.rightBarButtonItem = addButton
        }
        checkCountLabel.text = "\(count)/10"
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
}
