//
//  AddDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import FirebaseAuth
import SnapKit
import UIKit

//노티피케이션
extension Notification.Name {
    static let newDrivingRecordAdded = Notification.Name("newDrivingRecordAdded")
}

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
    
    func buttonActions() {
        addDrivingView.saveButton.addAction(UIAction(handler: { [self] _ in
            print("---> addDrivingView 저장 버튼 클릭 했어요")
            
            let timeStamp = Date().toString()
            let id = UUID().uuidString
            let departDistance = Int(addDrivingView.totalDistanceTextField.text ?? "0") ?? 0
            let arriveDistance = Int(addDrivingView.arriveDistanceTextField.text ?? "0") ?? 0
            let driveDistance = Int(addDrivingView.driveDistenceTextField.text ?? "0") ?? 0
            let userEmail = Auth.auth().currentUser?.email
            
            let newDriving = Driving(timeStamp: timeStamp, id: id, departDistance: departDistance, arriveDistance: arriveDistance, driveDistance: driveDistance, userEmail: userEmail)
            
            FirestoreService.firestoreService.saveDriving(driving: newDriving) { error in
                if let error = error {
                    print("    ----> 주행기록 저장 실패: \(error)")
                } else {
                    print("    ----> 주행기록 저장 성공!")
                    
                    NotificationCenter.default.post(name: .newDrivingRecordAdded, object: newDriving)
                }
            }
            
            self.dismiss(animated: true)}), for: .touchUpInside)
        
        addDrivingView.cancelButton.addAction(UIAction(handler: { _ in
            print("---> addDrivingView 취소 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
}
