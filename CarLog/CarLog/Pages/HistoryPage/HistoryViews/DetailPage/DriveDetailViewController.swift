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

class DriveDetailViewController: UIViewController, UITextFieldDelegate {
    let db = Firestore.firestore()
    
    var drivingData: Driving?
    
    lazy var drivingDetailView: DrivingDetailView = {
        let drivingDetailView = DrivingDetailView()
        return drivingDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCoustomColor
        
        view.addSubview(drivingDetailView)
        drivingDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        //키보드 스크롤
        registerForKeyboardNotifications()
        
        //detailDrivingView에 운행 목적 텍스트 필드 글자수 제한 설정 시
        drivingDetailView.drivingPurposeTextField.delegate = self
        
        navigationUI()
        loadDrivingData()
        autoCalculate()
        buttonActions()
    }
    
    //MARK: - 주행기록 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "주행기록"
        
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
        drivingDetailView.scrollView.contentInset = contentInset
        drivingDetailView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        drivingDetailView.scrollView.contentInset = contentInset
        drivingDetailView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drivingDetailView.endEditing(true)
    }
    
    //MARK: - 운행 목적 텍스트 입력 수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maxLength = 15
        return updatedText.count <= maxLength
    }
    
    //MARK: - 주행기록 디테일페이지 데이터 로드
    func loadDrivingData() {
        FirestoreService.firestoreService.loadDriving { _ in
            if let drivings = self.drivingData {
                self.drivingDetailView.drivingPurposeTextField.text = "\(drivings.drivingPurpose ?? "")"
                self.drivingDetailView.totalDistanceTextField.text = "\(drivings.departDistance ?? 0)"
                self.drivingDetailView.arriveDistanceTextField.text = "\(drivings.arriveDistance ?? 0)"
                self.drivingDetailView.driveDistenceTextField.text = "\(drivings.driveDistance ?? 0)"
            } else {
                print("데이터 로드 중 오류 발생")
            }
        }
    }
    
    //MARK: - 주행거리 자동 계산
    func autoCalculate() {
        func calculate() {
            let totalDistanceText = Int(drivingDetailView.totalDistanceTextField.text ?? "") ?? 0
            let arriveDistanceText = Int(drivingDetailView.arriveDistanceTextField.text ?? "") ?? 0
            let driveDistenceText = arriveDistanceText - totalDistanceText
            drivingDetailView.driveDistenceTextField.text = String(driveDistenceText)
        }
        
        //누적(출발) 주행거리 텍스트필드의 값이 변경될 때 마다 도착에서 출발을 뺀다.
        drivingDetailView.totalDistanceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
        
        //도착 주행거리 텍스트필드의 값이 변경될 때 마다 도착에서 출발을 뺀다.
        drivingDetailView.arriveDistanceTextField.addAction(UIAction(handler: { _ in
            calculate()
        }), for: .editingChanged)
    }
    
    //MARK: - 수정, 삭제 버튼 엑션
    func buttonActions() {
        drivingDetailView.upDateButton.addAction(UIAction(handler: { [self] _ in
            print("---> driveDetailView 수정 버튼 눌렀어요")
            if let drivingID = drivingData?.documentID {
                var updatedData: [String: Any] = [:]
                
                if let drivingPurposeText = drivingDetailView.drivingPurposeTextField.text {
                    updatedData["drivingPurpose"] = drivingPurposeText
                }
                
                if let totalDistanceText = drivingDetailView.totalDistanceTextField.text, let totalDistance = 
                    Int(totalDistanceText) {
                    updatedData["departDistance"] = totalDistance
                }
                
                if let arriveDistanceText = drivingDetailView.arriveDistanceTextField.text, let arriveDistance =
                    Int(arriveDistanceText) {
                    updatedData["arriveDistance"] = arriveDistance
                }
                
                if let driveDistanceText = drivingDetailView.driveDistenceTextField.text, let driveDistance = 
                    Int(driveDistanceText) {
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
        }), for: .touchUpInside)
        
        drivingDetailView.removeButton.addAction(UIAction(handler: { [self] _ in
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
        }), for: .touchUpInside)
    }
}
