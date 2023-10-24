//
//  DriveDetailViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.
// 취소 수정버튼 히든처리 , 네비게이션바 아이템 수정 버튼 추가 // 주행기록 문구 네비게이션컨트롤러로

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DriveDetailViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var drivingData: Driving?
    
    //    lazy var plusButton: UIBarButtonItem = {
    //        let plusButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(doDeleted))
    //        plusButton.tintColor = .mainNavyColor
    //        return plusButton
    //    }()
    //
    //    @objc func doDeleted() {
    //        print("--> go to AddPage")
    //
    //    }
    //
    //    func navigationUI() {
    //        self.navigationItem.rightBarButtonItem = self.plusButton
    //    }
    
    lazy var driveDetailView: DriveDetailView = {
        let driveDetailView = DriveDetailView()
        return driveDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        //        navigationUI()
        
        view.addSubview(driveDetailView)
        driveDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadDrivingData()
        
        driveDetailView.saveButton.addTarget(self, action: #selector(didSaveButton), for: .touchUpInside)
        driveDetailView.removeButton.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        
    }
    
    func loadDrivingData() {
        FirestoreService.firestoreService.loadDriving { result in
            if let drivings = result {
                HistoryPageViewController().drivingDummy = drivings
                DispatchQueue.main.async {
                    self.driveDetailView.totalDistanceTextField.text = "\(self.drivingData?.departDistance ?? 0)"
                    self.driveDetailView.arriveDistanceTextField.text = "\(self.drivingData?.arriveDistance ?? 0)"
                    self.driveDetailView.driveDistenceTextField.text = "\(self.drivingData?.driveDistance ?? 0)"
                }
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    
    @objc func didSaveButton() {
        print("---> driveDetailView 수정 버튼 눌렀어요")
        //        navigationController?.pushViewController(HistoryPageViewController(), animated: true)
        
        
    }
    
    @objc func didCancelButton() {
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
