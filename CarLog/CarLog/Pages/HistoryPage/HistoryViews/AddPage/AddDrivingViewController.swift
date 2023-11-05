//
//  AddDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import UIKit

import FirebaseAuth
import SnapKit

// 노티피케이션
extension Notification.Name {
    static let newDrivingRecordAdded = Notification.Name("newDrivingRecordAdded")
}

class AddDrivingViewController: UIViewController, UITextFieldDelegate {
    
    lazy var addDrivingView: AddDrivingView = {
        let addDrivingView = AddDrivingView()
        return addDrivingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCoustomColor
        
        view.addSubview(addDrivingView)
        addDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addDrivingView.drivingPurposeTextField.delegate = self
        
        autoCalculate()
        buttonActions()
    }

//MARK: - 운행 목적 텍스트 입력 수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maxLength = 15
        return updatedText.count <= maxLength
    }
    
//MARK: - 주행거리 자동 계산
    func autoCalculate() {
        func calculate() {
            let totalDistanceText = Int(addDrivingView.totalDistanceTextField.text ?? "") ?? 0
            let arriveDistanceText = Int(addDrivingView.arriveDistanceTextField.text ?? "") ?? 0
            let driveDistenceText = arriveDistanceText - totalDistanceText
            addDrivingView.driveDistenceTextField.text = String(driveDistenceText)
        }
        
        //누적(출발) 주행거리 텍스트필드의 값이 변경될 때 마다 도착에서 출발을 뺀다.
        addDrivingView.totalDistanceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
        
        //도착 주행거리 텍스트필드의 값이 변경될 때 마다 도착에서 출발을 뺀다.
        addDrivingView.arriveDistanceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
    }
    
    func buttonActions() {
        addDrivingView.saveButton.addAction(UIAction(handler: { [self] _ in
            print("---> addDrivingView 저장 버튼 클릭 했어요")
            
            let timeStamp = Date().toString()
            let id = UUID().uuidString
            let drivingPurpose = addDrivingView.drivingPurposeTextField.text ?? ""
            let departDistance = Int(addDrivingView.totalDistanceTextField.text ?? "0") ?? 0
            let arriveDistance = Int(addDrivingView.arriveDistanceTextField.text ?? "0") ?? 0
            let driveDistance = Int(addDrivingView.driveDistenceTextField.text ?? "0") ?? 0
            let userEmail = Auth.auth().currentUser?.email
            
            let newDriving = Driving(timeStamp: timeStamp, drivingPurpose: drivingPurpose, id: id, departDistance: departDistance, arriveDistance: arriveDistance, driveDistance: driveDistance, userEmail: userEmail)
            
            FirestoreService.firestoreService.saveDriving(driving: newDriving) { error in
                if let error = error {
                    print("    ----> 주행기록 저장 실패: \(error)")
                } else {
                    print("    ----> 주행기록 저장 성공!")
                    
                    NotificationCenter.default.post(name: .newDrivingRecordAdded, object: newDriving)
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
