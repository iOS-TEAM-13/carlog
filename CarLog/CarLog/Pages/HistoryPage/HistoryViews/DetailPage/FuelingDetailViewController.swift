//
//  FuelingDetailViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.

import UIKit

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SnapKit

class FuelingDetailViewController: UIViewController {
    let db = Firestore.firestore()
    
    var fuelingData: Fueling?
    
    lazy var fuelingDetailView: FuelingDetailView = {
        let fuelingDetailView = FuelingDetailView()
        return fuelingDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(fuelingDetailView)
        fuelingDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadFuelingData()
        
        fuelingDetailView.upDateButton.addTarget(self, action: #selector(didUpDateButton), for: .touchUpInside)
        fuelingDetailView.removeButton.addTarget(self, action: #selector(didRemoveButton), for: .touchUpInside)
    }
    
    func loadFuelingData() {
        FirestoreService.firestoreService.loadFueling { _ in
            if let fuelings = self.fuelingData {
                self.fuelingDetailView.totalDistanceTextField.text = "\(fuelings.totalDistance ?? 0)"
                self.fuelingDetailView.priceTextField.text = "\(fuelings.price ?? 0)"
                self.fuelingDetailView.countTextField.text = "\(fuelings.count ?? 0.0)"
                self.fuelingDetailView.totalPriceTextField.text = "\(fuelings.totalDistance ?? 0)"
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    @objc func didUpDateButton() {
        print("---> fuelingDetailView 수정 버튼 눌렀어요")
        if let fuelingID = fuelingData?.documentID {
            var updatedData: [String: Any] = [:]
            
            if let totalDistanceText = fuelingDetailView.totalDistanceTextField.text, let totalDistance = Int(totalDistanceText) {
                updatedData["totalDistance"] = totalDistance
            }
            
            if let priceText = fuelingDetailView.priceTextField.text, let price = Int(priceText) {
                updatedData["price"] = price
            }
            
            if let countText = fuelingDetailView.countTextField.text, let count = Double(countText) {
                updatedData["count"] = count
            }
            
            if let totalPriceText = fuelingDetailView.totalPriceTextField.text, let totalPrice = Double(totalPriceText) {
                updatedData["totalPrice"] = totalPrice
            }
            
            FirestoreService.firestoreService.updateFueling(fuelingID: fuelingID, updatedData: updatedData) { error in
                if let error = error {
                    print("주유 데이터 업데이트 실패: \(error)")
                } else {
                    print("주유 데이터 업데이트 성공")
                    HistoryPageViewController().fuelingCollectionView.fuelingCollectionView.reloadData()
                    
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @objc func didRemoveButton() {
        print("---> driveDetailView 삭제 버튼 눌렀어요")
        
        if let fuelingID = fuelingData?.documentID {
            FirestoreService.firestoreService.removeFueling(fuelingID: fuelingID) { error in
                if let error = error {
                    print("주유 데이터 삭제 실패: \(error)")
                } else {
                    print("주유 데이터 삭제 성공")
                    HistoryPageViewController().fuelingCollectionView.fuelingCollectionView.reloadData()
                    
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
