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
        
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(fuelingDetailView)
        fuelingDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationUI()
        
        //키보드 스크롤
        registerForKeyboardNotifications()
        
        loadFuelingData()
        
        //자동 계산
        autoCalculate()
        
        //수정, 삭제 버튼 클릭 이벤트
        buttonActions()
    }
    
    //MARK: - 주행기록 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "주유기록"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goToHistoryPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToHistoryPage() {
        print("디테일 페이지에서 히스토리 페이지로 뒤로간다")
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    // MARK: - Keyboard 관련
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        fuelingDetailView.scrollView.contentInset = contentInset
        fuelingDetailView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        fuelingDetailView.scrollView.contentInset = contentInset
        fuelingDetailView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fuelingDetailView.endEditing(true)
    }
    
    //MARK: - 주행기록 디테일페이지 데이터 로드
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
    
    //MARK: - 주행거리 자동 계산
    func autoCalculate() {
        func calculate() {
            let countText = fuelingDetailView.countTextField.text ?? ""
            let priceText = Int(fuelingDetailView.priceTextField.text ?? "") ?? 0
            
            //수량이 소수점이면 곱하고 반올림
            if countText.range(of: ".") != nil {
                let countText = Double(countText) ?? 0
                let totalPriceText = round(Double(priceText) * countText * 0.1) / 0.1
                fuelingDetailView.totalPriceTextField.text = String(format: "%.0f", totalPriceText)
                
            //아니면 그냥 곱하기
            } else {
                let countText = Int(countText) ?? 0
                let totalPriceText = countText * priceText
                fuelingDetailView.totalPriceTextField.text = String(totalPriceText)
            }
        }
        
        //단가 텍스트필드의 값이 변경될 때 마다 수량이랑 곱한다.
        fuelingDetailView.priceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
        
        //수량 텍스트필드의 값이 변경될 때 마다 단가랑 곱한다.
        fuelingDetailView.countTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
    }
    
    //MARK: - 수정, 삭제 버튼 엑션
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
