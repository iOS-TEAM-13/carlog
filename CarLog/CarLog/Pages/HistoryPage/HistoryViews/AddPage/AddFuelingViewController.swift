//
//  AddFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import UIKit

import FirebaseAuth
import SnapKit

// 노티피케이션
extension Notification.Name {
    static let newFuelingRecordAdded = Notification.Name("newFuelingRecordAdded")
}

class AddFuelingViewController: UIViewController {
    lazy var addFuelingView: AddFuelingView = {
        let addFuelingView = AddFuelingView()
        return addFuelingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(addFuelingView)
        addFuelingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        buttonActions()
    }
    
    func buttonActions() {
        addFuelingView.saveButton.addAction(UIAction(handler: { [self] _ in
            print("---> addFuelingView 저장 버튼 클릭 했어요")
            
            let timeStamp = Date().toString()
            let id = UUID().uuidString
            let totalDistance = Int(addFuelingView.totalDistanceTextField.text ?? "0") ?? 0
            let price = Int(addFuelingView.priceTextField.text ?? "0") ?? 0
            let count = Double(addFuelingView.countTextField.text ?? "0") ?? 0.0
            let totalPrice = Int(addFuelingView.totalPriceTextField.text ?? "0") ?? 0
            let userEmail = Auth.auth().currentUser?.email
            
            let newFueling = Fueling(timeStamp: timeStamp, id: id, totalDistance: totalDistance, price: price, count: count, totalPrice: totalPrice, userEmail: userEmail)
            
            FirestoreService.firestoreService.saveFueling(fueling: newFueling) { error in
                if let error = error {
                    print("    ----> 주유기록 저장 실패: \(error)")
                } else {
                    print("    ----> 주유기록 저장 성공!")
                    
                    NotificationCenter.default.post(name: .newFuelingRecordAdded, object: newFueling)
                }
            }
            
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        addFuelingView.cancelButton.addAction(UIAction(handler: { _ in
            print("---> addFuelingView 취소 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
}
