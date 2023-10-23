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
            let departDistance = Double(addDrivingView.totalDistanceTextField.text ?? "0") ?? 0.0
            let arriveDistance = Double(addDrivingView.arriveDistanceTextField.text ?? "0") ?? 0.0
            let driveDistance = Double(addDrivingView.driveDistenceTextField.text ?? "0") ?? 0.0
            let userEmail = Auth.auth().currentUser?.email
            
            let newDriving = Driving(timeStamp: timeStamp, id: id, departDistance: departDistance, arriveDistance: arriveDistance, driveDistance: driveDistance, userEmail: userEmail)
            
            FirestoreService.firestoreService.saveDriving(driving: newDriving) { error in
                if let error = error {
                    print("    ----> 주행기록 저장 실패: \(error)")
                } else {
                    print("    ----> 주행기록 저장 성공!")
//화면에서 화면으로 데이터를 전달하는 방법, 업데이트 하는 방식을 팀원과 논의할것
//                    Notification Center: AddDrivingViewController에서 포스트된 노티피케이션을 구독하고, HistoryPageViewController에서 해당 노티피케이션을 받아 처리하는 방법입니다.
//
//                    AddDrivingViewController에서 노티피케이션을 포스트하고, HistoryPageViewController에서 옵저버로 등록하여 데이터를 업데이트합니다.
//
//                    싱글톤 또는 앱 델리게이트 사용: 앱 델리게이트나 싱글톤 클래스를 사용하여 앱 전반에 걸쳐 데이터를 공유할 수도 있습니다. 이것은 복잡한 앱에서 데이터 공유가 필요한 경우에 유용할 수 있습니다.
//
//                    선택한 방법에 따라 loadDrivingData 함수를 호출할 수 있게 되며, 데이터를 업데이트하여 추가한 내역이 즉시 화면에 표시될 것입니다.
                    NotificationCenter.default.post(name: .newDrivingRecordAdded, object: newDriving)
                    
//                    let view = HistoryPageViewController()
//                    view.drivingDummy.append(newDriving)
//                    FirestoreService.firestoreService.loadDriving { result in
//                        if let drivings = result {
//                            view.drivingDummy = drivings
//
//                            DispatchQueue.main.async {
//                                view.drivingCollectionView.drivingCollectionView.reloadData()
//                            }
//
//                            print("skdhkfhk")
//                            print(drivings)
//
//                        } else {
//                            print("데이터 로드 중 오류 발생")
//                        }
//                    }
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
