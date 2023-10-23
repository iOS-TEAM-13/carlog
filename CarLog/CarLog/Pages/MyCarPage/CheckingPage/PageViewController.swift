//
//  PageViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/17.
//

import FirebaseAuth
import SnapKit
import UIKit

class PageViewController: UIViewController {
    
    var componetsView: ComponentsView?
    var insuranceView: InsuranceView?
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(view: CheckingView, checkingView: componentsType) {
        super.init(nibName: nil, bundle: nil)
        if checkingView == .engineOil || checkingView == .missionOil || checkingView == .brakeOil || checkingView == .brakePad || checkingView == .tire || checkingView == .tireRotation || checkingView == .fuelFilter || checkingView == .wiperBlade || checkingView == .airconFilter {
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
                item.backgroundColor = .thirdColor
                item.setTitleColor(.black, for: .normal)
            }
            if let text = sender.titleLabel?.text {
                switch text {
                case "Jan":
                    view.calendarView.january.backgroundColor = .primaryColor
                    view.calendarView.january.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "1"
                case "Feb":
                    view.calendarView.february.backgroundColor = .primaryColor
                    view.calendarView.february.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "2"
                case "Mar":
                    view.calendarView.march.backgroundColor = .primaryColor
                    view.calendarView.march.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "3"
                case "Apr":
                    view.calendarView.april.backgroundColor = .primaryColor
                    view.calendarView.april.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "4"
                case "May":
                    view.calendarView.may.backgroundColor = .primaryColor
                    view.calendarView.may.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "5"
                case "Jun":
                    view.calendarView.june.backgroundColor = .primaryColor
                    view.calendarView.june.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "6"
                case "Jul":
                    view.calendarView.july.backgroundColor = .primaryColor
                    view.calendarView.july.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "7"
                case "Aug":
                    view.calendarView.august.backgroundColor = .primaryColor
                    view.calendarView.august.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "8"
                case "Sep":
                    view.calendarView.september.backgroundColor = .primaryColor
                    view.calendarView.september.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "9"
                case "Oct":
                    view.calendarView.october.backgroundColor = .primaryColor
                    view.calendarView.october.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "10"
                case "Nov":
                    view.calendarView.november.backgroundColor = .primaryColor
                    view.calendarView.november.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "11"
                case "Dec":
                    view.calendarView.december.backgroundColor = .primaryColor
                    view.calendarView.december.setTitleColor(.white, for: .normal)
                    Constants.carParts.insurance.currentTime = "12"
                default:
                    break
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    private func checkButtonTapped(sender: UIButton) {
        if let view = componetsView {
            let temp = [view.firstAnswerButton, view.secondAnswerButton, view.thirdAnswerButton, view.fourthAnswerButton, view.fifthAnswerButton]
            temp.forEach { item in
                item.backgroundColor = .thirdColor
                item.setTitleColor(.black, for: .normal)
            }
            
            switch sender.tag {
            case 1:
                view.firstAnswerButton.backgroundColor = .primaryColor
                view.firstAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.firstAnswerButton.titleLabel?.text ?? "")
            case 2:
                view.secondAnswerButton.backgroundColor = .primaryColor
                view.secondAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.secondAnswerButton.titleLabel?.text ?? "")
            case 3:
                view.thirdAnswerButton.backgroundColor = .primaryColor
                view.thirdAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.thirdAnswerButton.titleLabel?.text ?? "")
            case 4:
                view.fourthAnswerButton.backgroundColor = .primaryColor
                view.fourthAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.fourthAnswerButton.titleLabel?.text ?? "")
            case 5:
                view.fifthAnswerButton.backgroundColor = .primaryColor
                view.fifthAnswerButton.setTitleColor(.white, for: .normal)
                addCarParts(text: view.fifthAnswerButton.titleLabel?.text ?? "")
            default:
                break
            }
        }
        NotificationCenter.default.post(name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    private func addCarParts(text :String) {
        switch type {
        case "엔진 오일은 언제 교체하셨나요?":
            Constants.carParts.engineOil.currentTime = text
        case "미션 오일은 언제 교체하셨나요?":
            Constants.carParts.missionOil.currentTime = text
        case "브레이크 오일은 언제 교체하셨나요?":
            Constants.carParts.brakeOil.currentTime = text
        case "브레이크 패드는 언제 교체하셨나요?":
            Constants.carParts.brakePad.currentTime = text
        case "마지막 타이어 로테이션은 언제였나요?":
            Constants.carParts.tireRotation.currentTime = text
        case "타이어는 언제 교체하셨나요?":
            Constants.carParts.tire.currentTime = text
        case "연료 필터는 언제 교체하셨나요?":
            Constants.carParts.fuelFilter.currentTime = text
        case "와이퍼 블레이드는 언제 교체하셨나요?":
            Constants.carParts.wiper.currentTime = text
        case "에어컨 필터는 언제 교체하셨나요?":
            Constants.carParts.airconFilter.currentTime = text
        default:
            break
        }
    }
    
}
