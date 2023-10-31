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
        autoCalculate()
        buttonActions()
    }
    
    func loadFuelingData() {
        FirestoreService.firestoreService.loadFueling { _ in
            if let fuelings = self.fuelingData {
                self.fuelingDetailView.totalDistanceTextField.text = "\(fuelings.totalDistance ?? 0)"
                self.fuelingDetailView.priceTextField.text = "\(fuelings.price ?? 0)"
                self.fuelingDetailView.countTextField.text = "\(fuelings.count ?? "")"
                self.fuelingDetailView.totalPriceTextField.text = "\(fuelings.totalPrice ?? 0)"
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    func autoCalculate() {
        func calculate() {
            let countText = fuelingDetailView.countTextField.text ?? ""
            let priceText = Int(fuelingDetailView.priceTextField.text ?? "") ?? 0
            
            if countText.range(of: ".") != nil {
                let countText = Double(countText) ?? 0
                let totalPriceText = round(Double(priceText) * countText * 0.1) / 0.1
                fuelingDetailView.totalPriceTextField.text = String(format: "%.0f", totalPriceText)
            } else {
                let countText = Int(countText) ?? 0
                let totalPriceText = countText * priceText
                fuelingDetailView.totalPriceTextField.text = String(totalPriceText)
            }
        }
        
        fuelingDetailView.priceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
        
        fuelingDetailView.countTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
    }
    
    func buttonActions() {
        fuelingDetailView.upDateButton.addAction(UIAction(handler: { [self] _ in
            print("---> fuelingDetailView 수정 버튼 눌렀어요")
            if let fuelingID = fuelingData?.documentID {
                var updatedData: [String: Any] = [:]
                
                if let totalDistanceText = fuelingDetailView.totalDistanceTextField.text, let totalDistance = Int(totalDistanceText) {
                    updatedData["totalDistance"] = totalDistance
                }
                
                if let priceText = fuelingDetailView.priceTextField.text, let price = Int(priceText) {
                    updatedData["price"] = price
                }
                
                if let countText = fuelingDetailView.countTextField.text {
                    updatedData["count"] = countText
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
        }), for: .touchUpInside)
        
        fuelingDetailView.removeButton.addAction(UIAction(handler: { [self] _ in
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
        }), for: .touchUpInside)
    }
}
