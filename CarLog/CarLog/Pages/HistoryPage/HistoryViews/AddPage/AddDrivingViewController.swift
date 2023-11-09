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
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(addDrivingView)
        addDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationUI()
        
        //키보드 스크롤
        registerForKeyboardNotifications()
        
        //addDrivingView에 운행 목적 텍스트 필드 글자수 제한 설정 시
        addDrivingView.drivingPurposeTextField.delegate = self
        
        //자동 계산
        autoCalculate()
        
        //저장, 취소 버튼 클릭 이벤트
        buttonActions()
    }
    
    //MARK: - 주행기록 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "주행기록 추가"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.addImageButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(goToHistoryPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToHistoryPage() {
        print("주행기록 추가 페이지에서 히스토리 페이지로 뒤로간다")
        self.dismiss(animated: true, completion: nil)
    }
    
    //주행거리 추가 페이지에서 +버튼 노출
    lazy var addImageButton: UIBarButtonItem = {
        let addImageButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goAddImage))
        addImageButton.tintColor = .mainNavyColor
        return addImageButton
    }()
    
    //주행거리 추가 페이지에서 +버튼 클릭 시 사진 선택 페이지로 이동
    @objc func goAddImage() {
        let visionDrivingViewController = VisionDrivingViewController()
        navigationController?.pushViewController(visionDrivingViewController, animated: true)
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
        addDrivingView.scrollView.contentInset = contentInset
        addDrivingView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        addDrivingView.scrollView.contentInset = contentInset
        addDrivingView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addDrivingView.endEditing(true)
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
    
    //MARK: - 저장, 취소 버튼 클릭 이벤트
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
