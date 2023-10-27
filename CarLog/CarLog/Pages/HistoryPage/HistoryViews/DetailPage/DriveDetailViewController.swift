//
//  DriveDetailViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.

import UIKit

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SnapKit

class DriveDetailViewController: UIViewController {
    let db = Firestore.firestore()
    
    var drivingData: Driving?
    
    lazy var drivingDetailView: DrivingDetailView = {
        let drivingDetailView = DrivingDetailView()
        return drivingDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(drivingDetailView)
        drivingDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadDrivingData()
        
        drivingDetailView.upDateButton.addTarget(self, action: #selector(didUpDateButton), for: .touchUpInside)
        drivingDetailView.removeButton.addTarget(self, action: #selector(didRemoveButton), for: .touchUpInside)
    }
    
    func loadDrivingData() {
        FirestoreService.firestoreService.loadDriving { _ in
            if let drivings = self.drivingData {
                self.drivingDetailView.totalDistanceTextField.text = "\(drivings.departDistance ?? 0)"
                self.drivingDetailView.arriveDistanceTextField.text = "\(drivings.arriveDistance ?? 0)"
                self.drivingDetailView.driveDistenceTextField.text = "\(drivings.driveDistance ?? 0)"
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    @objc func didUpDateButton() {
        print("---> driveDetailView 수정 버튼 눌렀어요")
        if let drivingID = drivingData?.documentID {
            var updatedData: [String: Any] = [:]
            
            if let totalDistanceText = drivingDetailView.totalDistanceTextField.text, let totalDistance = Double(totalDistanceText) {
                updatedData["departDistance"] = totalDistance
            }
            
            if let arriveDistanceText = drivingDetailView.arriveDistanceTextField.text, let arriveDistance = Double(arriveDistanceText) {
                updatedData["arriveDistance"] = arriveDistance
            }
            
            if let driveDistanceText = drivingDetailView.driveDistenceTextField.text, let driveDistance = Double(driveDistanceText) {
                updatedData["driveDistance"] = driveDistance
            }
            
            FirestoreService.firestoreService.updateDriving(drivingID: drivingID, updatedData: updatedData) { error in
                if let error = error {
                    print("주행 데이터 업데이트 실패: \(error)")
                } else {
                    print("주행 데이터 업데이트 성공")
                    HistoryPageViewController().drivingCollectionView.drivingCollectionView.reloadData()
                    
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @objc func didRemoveButton() {
        print("---> driveDetailView 삭제 버튼 눌렀어요")
        if let drivingID = drivingData?.documentID {
            FirestoreService.firestoreService.removeDriving(drivingID: drivingID) { error in
                if let error = error {
                    print("주행 데이터 삭제 실패: \(error)")
                } else {
                    print("주행 데이터 삭제 성공")
                    HistoryPageViewController().drivingCollectionView.drivingCollectionView.reloadData()
                    
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
