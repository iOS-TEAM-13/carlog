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

        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(addFuelingView)
        addFuelingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationUI()
        
        //키보드 스크롤
        registerForKeyboardNotifications()
        
        //자동 계산
        autoCalculate()
        
        //저장, 취소 버튼 클릭 이벤트
        buttonActions()
    }
    
    //MARK: - 주행기록 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "주유기록 추가"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
        //주유 사진 인식 + 버튼 숨김처리 - 주말에 해라
//        self.navigationItem.rightBarButtonItem = self.addImageButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(goToHistoryPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToHistoryPage() {
        print("주유기록 추가 페이지에서 히스토리 페이지로 뒤로간다")
        self.dismiss(animated: true, completion: nil)
    }
    
    //주유 추가 페이지에서 +버튼 노출
    lazy var addImageButton: UIBarButtonItem = {
        let addImageButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goAddImage))
        addImageButton.tintColor = .mainNavyColor
        return addImageButton
    }()
    
    //주유 추가 페이지에서 +버튼 클릭 시 사진 선택 페이지로 이동
    @objc func goAddImage() {
        let visionFuelingViewController = VisionFuelingViewController()
        navigationController?.pushViewController(visionFuelingViewController, animated: true)
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
        addFuelingView.scrollView.contentInset = contentInset
        addFuelingView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        addFuelingView.scrollView.contentInset = contentInset
        addFuelingView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addFuelingView.endEditing(true)
    }
    
    //MARK: - 주유 자동 계산
    func autoCalculate() {
        func calculate() {
            let countText = addFuelingView.countTextField.text ?? ""
            let priceText = Int(addFuelingView.priceTextField.text ?? "") ?? 0
            
            //수량에 소수점이 있다면 반올림 처리
            if countText.range(of: ".") != nil {
                let countText = Double(countText) ?? 0
                let totalPriceText = round(Double(priceText) * countText * 0.1) / 0.1
                addFuelingView.totalPriceTextField.text = String(format: "%.0f", totalPriceText)
            
            //아니면 그냥 곱하기
            } else {
                let countText = Int(countText) ?? 0
                let totalPriceText = countText * priceText
                addFuelingView.totalPriceTextField.text = String(totalPriceText)
            }
        }
        
        //단가 텍스트필드의 값이 변경될 때 마다 수량이랑 곱한다.
        addFuelingView.priceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
        
        //수량 텍스트필드의 값이 변경될 떄 마다 단가랑 곱한다.
        addFuelingView.countTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
    }
    
    //MARK: - 저장, 취소 버튼 클릭 이벤트
    func buttonActions() {
        addFuelingView.saveButton.addAction(UIAction(handler: { [self] _ in
            print("---> addFuelingView 저장 버튼 클릭 했어요")
            
            let timeStamp = Date().toString()
            let id = UUID().uuidString
            let totalDistance = Int(addFuelingView.totalDistanceTextField.text ?? "0") ?? 0
            let price = Int(addFuelingView.priceTextField.text ?? "0") ?? 0
            let count = String(addFuelingView.countTextField.text ?? "")
            let totalPrice = Int(addFuelingView.totalPriceTextField.text ?? "0") ?? 0
            let userEmail = Constants.currentUser.userEmail
            
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
