//
//  AddDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddDrivingViewController: UIViewController {
    
    lazy var addDrivingView: AddDrivingView = {
        let addDrivingView = AddDrivingView()
        return addDrivingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(addDrivingView)
        addDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        buttonActions()
        
    }
    
    //
    //        FirestoreService.firestoreService.saveUsers(
    //            user: User(userId: "abc", email: "hhn0212@naver.com", password: "Rlawlgns1!",
    //            car: Car(number: "00서 0000", maker: "기아", name: "K5", oilType: "휘발유", nickName: "붕붕", totalDistance: 170,
    //            carInfo: CarInfo(engineOil: "3개월 전", missionOil: "3개월 전", brakeOil: "3개월 전", brakePad: "3개월 전", tire: "3개월 전",tireRotation: "3개월 전", fuelFilter: "3개월 전", wiper: "3개월 전", airconFilter: "3개월 전", insurance: "3개월 전"),
    //                     driving: [Driving(timeStamp: "2023.10.15", departDistance: 170, arriveDistance: 180, driveDistance: 10)], fueling: [nil]), post: nil)) { error in }
    
    func buttonActions() {
        addDrivingView.saveButton.addAction(UIAction(handler: { [self] _ in
            print("---> addDrivingView 저장 버튼 클릭 했어요")
            
            //
            let timeStamp = "" // 여기에 적절한 타임스탬프 값을 설정
            let departDistance = Double(addDrivingView.totalDistanceTextField.text ?? "0") ?? 0.0
            let arriveDistance = Double(addDrivingView.arriveDistanceTextField.text ?? "0") ?? 0.0
            let driveDistance = Double(addDrivingView.driveDistenceTextField.text ?? "0") ?? 0.0
            let userEmail = "" // 여기에 사용자 이메일 값을 설정
            
            let newDriving = Driving(timeStamp: timeStamp, id: "", departDistance: departDistance, arriveDistance: arriveDistance, driveDistance: driveDistance, userEmail: userEmail)
            
            FirestoreService.firestoreService.saveDriving(driving: newDriving) { error in
                if let error = error {
                    print("    ----> 주행기록 저장 실패: \(error)")
                } else {
                    print("    ----> 주행기록 저장 성공!")
                }
            }
            
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        addDrivingView.cancelButton.addAction(UIAction(handler: { _ in
            print("---> addDrivingView 취소 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
}
