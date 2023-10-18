//
//  MyCarCheckViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class MyCarCheckViewController: UIViewController {
    private let engineOilView = PageViewController(view: CheckingView(title: "엔진 오일은 언제 교체하셨나요?", firstButton: "6개월 전", secondButton: "3개월 전", thirdbutton: "1개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let missionOilView = PageViewController(view: CheckingView(title: "미션 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let brakeOilView = PageViewController(view: CheckingView(title: "브레이크 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let brakePadView = PageViewController(view: CheckingView(title: "브레이크 패드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let tireRotationView = PageViewController(view: CheckingView(title: "마지막 타이어 로테이션은 언제였나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let tireView = PageViewController(view: CheckingView(title: "타이어는 언제 교체하셨나요?", firstButton: "3년 전", secondButton: "2년 전", thirdbutton: "1년 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let fuelFilterView = PageViewController(view: CheckingView(title: "연료 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let wiperBladeView = PageViewController(view: CheckingView(title: "와이퍼 블레이드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let airconFilterView = PageViewController(view: CheckingView(title: "에어컨 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"), checkingView: .normalView)
    private let insuranceView = PageViewController(view:  CheckingView(title: "보험 가입 시기는 언제쯤인가요?", firstButton: "", secondButton: "", thirdbutton: "", fourthButton: "", fifthButton: ""), checkingView: .insuranceView)
    
    lazy var dataViewControllers: [UIViewController] = {
            return [engineOilView, missionOilView, brakeOilView, brakePadView, tireRotationView, tireView, fuelFilterView, wiperBladeView, airconFilterView, insuranceView]
        }()
    
    lazy var pageViewController: UIPageViewController = {
           let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
           return vc
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupDelegate()
        setPageViewController()
    }
    
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
