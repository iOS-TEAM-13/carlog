//
//  PageViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/17.
//

import UIKit

import FirebaseAuth
import SnapKit

class PageViewController: UIViewController {
    // MARK: Properties

    var componetsView: ComponentsView?
    var insuranceView: InsuranceView?
    var type = ""
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(view: CheckingView, checkingView: componentsType) {
        super.init(nibName: nil, bundle: nil)
        if checkingView == .engineOil || checkingView == .missionOil || checkingView == .brakeOil || checkingView == .brakePad || checkingView == .tireRotation || checkingView == .tire || checkingView == .fuelFilter || checkingView == .wiperBlade || checkingView == .airconFilter {
            componetsView = ComponentsView(view: view)
            type = componetsView?.checkTitleLabel.text ?? ""
            setupComponetsView()
            componentsButtonActions()
        } else {
            insuranceView = InsuranceView(view: view)
            setupInsuranceView()
            insuranceButtonActions()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Method

    private func setupComponetsView() {
        view.addSubview(componetsView!)
        
        componetsView!.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupInsuranceView() {
        view.addSubview(insuranceView!)
        
        insuranceView!.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: ComponentsView

    private func componentsButtonActions() {
        if let view = componetsView {
            view.firstAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.firstAnswerButton)
            }), for: .touchUpInside)
            view.secondAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.secondAnswerButton)
            }), for: .touchUpInside)
            view.thirdAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.thirdAnswerButton)
            }), for: .touchUpInside)
            view.fourthAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.fourthAnswerButton)
            }), for: .touchUpInside)
            view.fifthAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.fifthAnswerButton)
            }), for: .touchUpInside)
        }
    }
    
    private func checkButtonTapped(sender: UIButton) {
        if let view = componetsView {
            let temp = [view.firstAnswerButton, view.secondAnswerButton, view.thirdAnswerButton, view.fourthAnswerButton, view.fifthAnswerButton]
            temp.forEach { item in
                item.backgroundColor = .buttonSkyBlueColor
                item.setTitleColor(.black, for: .normal)
            }
            switch sender.tag {
            case 1:
                view.firstAnswerButton.backgroundColor = .mainNavyColor
                view.firstAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.firstAnswerButton.titleLabel?.text ?? "")
            case 2:
                view.secondAnswerButton.backgroundColor = .mainNavyColor
                view.secondAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.secondAnswerButton.titleLabel?.text ?? "")
            case 3:
                view.thirdAnswerButton.backgroundColor = .mainNavyColor
                view.thirdAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.thirdAnswerButton.titleLabel?.text ?? "")
            case 4:
                view.fourthAnswerButton.backgroundColor = .mainNavyColor
                view.fourthAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.fourthAnswerButton.titleLabel?.text ?? "")
            case 5:
                view.fifthAnswerButton.backgroundColor = .mainNavyColor
                view.fifthAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.fifthAnswerButton.titleLabel?.text ?? "")
            default:
                break
            }
        }
        NotificationCenter.default.post(name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    private func addCarParts(text: String) {
        for i in 0...Constants.carParts.parts.count - 1 {
            switch (type, Constants.carParts.parts[i].name) {
            case ("엔진 오일은 언제 교체하셨나요?", .engineOil):
                Constants.carParts.parts[i].currentTime = text
            case ("미션 오일은 언제 교체하셨나요?", .missionOil):
                Constants.carParts.parts[i].currentTime = text
            case ("브레이크 오일은 언제 교체하셨나요?", .brakeOil):
                Constants.carParts.parts[i].currentTime = text
            case ("브레이크 패드는 언제 교체하셨나요?", .brakePad):
                Constants.carParts.parts[i].currentTime = text
            case ("마지막 타이어 로테이션은 언제였나요?", .tireRotation):
                Constants.carParts.parts[i].currentTime = text
            case ("타이어는 언제 교체하셨나요?", .tire):
                Constants.carParts.parts[i].currentTime = text
            case ("연료 필터는 언제 교체하셨나요?", .fuelFilter):
                Constants.carParts.parts[i].currentTime = text
            case ("와이퍼 블레이드는 언제 교체하셨나요?", .wiperBlade):
                Constants.carParts.parts[i].currentTime = text
            case ("에어컨 필터는 언제 교체하셨나요?", .airconFilter):
                Constants.carParts.parts[i].currentTime = text
            default:
                break
            }
        }
    }
    
    // MARK: InsuranceView

    private func insuranceButtonActions() {
        if let view = insuranceView {
            [view.calendarView.january, view.calendarView.february, view.calendarView.march, view.calendarView.april, view.calendarView.may, view.calendarView.june, view.calendarView.july, view.calendarView.august, view.calendarView.september, view.calendarView.october, view.calendarView.november, view.calendarView.december].forEach { item in
                item.addAction(UIAction(handler: { _ in
                    self.calendarButtonTapped(sender: item)
                }), for: .touchUpInside)
            }
        }
    }
    
    private func calendarButtonTapped(sender: UIButton) {
        if let view = insuranceView {
            [view.calendarView.january, view.calendarView.february, view.calendarView.march, view.calendarView.april, view.calendarView.may, view.calendarView.june, view.calendarView.july, view.calendarView.august, view.calendarView.september, view.calendarView.october, view.calendarView.november, view.calendarView.december].forEach { item in
                item.backgroundColor = .buttonSkyBlueColor
                item.setTitleColor(.black, for: .normal)
            }
            if let text = sender.titleLabel?.text {
                for i in 0...Constants.carParts.parts.count - 1 {
                    if Constants.carParts.parts[i].name == .insurance {
                        switch text {
                        case "Jan":
                            view.calendarView.january.backgroundColor = .mainNavyColor
                            view.calendarView.january.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "1"
                        case "Feb":
                            view.calendarView.february.backgroundColor = .mainNavyColor
                            view.calendarView.february.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "2"
                        case "Mar":
                            view.calendarView.march.backgroundColor = .mainNavyColor
                            view.calendarView.march.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "3"
                        case "Apr":
                            view.calendarView.april.backgroundColor = .mainNavyColor
                            view.calendarView.april.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "4"
                        case "May":
                            view.calendarView.may.backgroundColor = .mainNavyColor
                            view.calendarView.may.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "5"
                        case "Jun":
                            view.calendarView.june.backgroundColor = .mainNavyColor
                            view.calendarView.june.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "6"
                        case "Jul":
                            view.calendarView.july.backgroundColor = .mainNavyColor
                            view.calendarView.july.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "7"
                        case "Aug":
                            view.calendarView.august.backgroundColor = .mainNavyColor
                            view.calendarView.august.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "8"
                        case "Sep":
                            view.calendarView.september.backgroundColor = .mainNavyColor
                            view.calendarView.september.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "9"
                        case "Oct":
                            view.calendarView.october.backgroundColor = .mainNavyColor
                            view.calendarView.october.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "10"
                        case "Nov":
                            view.calendarView.november.backgroundColor = .mainNavyColor
                            view.calendarView.november.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "11"
                        case "Dec":
                            view.calendarView.december.backgroundColor = .mainNavyColor
                            view.calendarView.december.setTitleColor(.white, for: .normal)
                            Constants.carParts.parts[i].currentTime = "12"
                        default:
                            break
                        }
                    }
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name("completedCheckingView"), object: nil)
    }
}
