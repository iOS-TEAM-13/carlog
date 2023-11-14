import UIKit

import FirebaseAuth
import FirebaseFirestore
import MessageUI
import SnapKit

class MyPageViewController: UIViewController, MFMailComposeViewControllerDelegate {
    // MARK: - Properties
    
    lazy var myPageView = MyPageView()
    lazy var myPageSettingView = MyPageSettingView()
    
    lazy var carDummy = Constants.currentUser
    
    var isEditMode = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        setupUI()
        
        addTargetButton()
        checkCarNumberButtonAction()
        checkNickNameButtonAction()
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI() // ⭐ 내 차 정보 가져오기
        
        if isEditMode {
            toggleTextFieldsEditing(enable: false)
            editButtonChanged(editMode: false)
        }
        
    }
    
    func addTargetButton() {
        myPageView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        myPageView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        myPageSettingView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageSettingView.quitUserButton.addTarget(self, action: #selector(quitUserButtonTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        myPageSettingView.personalRegulations.addGestureRecognizer(tap)
        //        myPageView.inquiryButton.addTarget(self, action: #selector(dialPhoneNumber), for: .touchUpInside)
//        myPageSettingView.inquiryButton.addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://carlog.notion.site/3b018e85e94443da9a8d533525d3cf64?pvs=4") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func editButtonTapped() {
        isEditMode = !isEditMode
        toggleTextFieldsEditing(enable: isEditMode)
        editButtonChanged(editMode: isEditMode)
    }
    
    @objc private func cancelButtonTapped() {
        // 취소 버튼,현재 입력된 내용을 초기값으로 설정
        myPageView.carNumberTextField.text = carDummy.number
        myPageView.carNameTextField.text = carDummy.name
        myPageView.carMakerTextField.text = carDummy.maker
        myPageView.carOilTypeTextField.text = carDummy.oilType
        myPageView.carNickNameTextField.text = carDummy.nickName
        if let totalDistance = carDummy.totalDistance {
            myPageView.carTotalDistanceTextField.text = String(totalDistance)
        } else {
            myPageView.carTotalDistanceTextField.text = "0.0"
        }
        toggleTextFieldsEditing(enable: !isEditMode)
        editButtonChanged(editMode: !isEditMode)
    }
    
    
    private func toggleTextFieldsEditing(enable: Bool) {
        [myPageView.carNumberTextField, myPageView.carNameTextField, myPageView.carMakerTextField, myPageView.carOilTypeTextField, myPageView.carNickNameTextField, myPageView.carTotalDistanceTextField].forEach {
            $0.isUserInteractionEnabled = enable
        }
    }
    
    private func editButtonChanged(editMode: Bool) {
        if editMode {
            tabBarController?.tabBar.isHidden = true
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "checkmark.circle", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            myPageView.cancelButton.isHidden = false
            //            myPageView.myWritingButton.isHidden = true
            myPageView.checkCarNumberButton.isHidden = false
            myPageView.checkCarNickNameButton.isHidden = false
            myPageSettingView.myPageDesignStackView.isHidden = true
//            myPageSettingView.inquiryButton.isHidden = true
        } else {
            tabBarController?.tabBar.isHidden = false
            guard let checkCarNumber = self.myPageView.carNumberTextField.text,
                  let checkCarNickName = self.myPageView.carNickNameTextField.text
            else {
                return
            }
            // 조건을 만족하지 않을 때 경고 표시
            if checkCarNumber.isEmpty {
                self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
                return
            } else if checkCarNickName.isEmpty {
                self.showAlert(message: "닉네임을 꼭 작성해 주세요", completion: {})
                return
            }
            
            
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            myPageView.cancelButton.isHidden = true
            //            myPageView.myWritingButton.isHidden = false
            myPageView.checkCarNumberButton.isHidden = true
            myPageView.checkCarNickNameButton.isHidden = true
            myPageSettingView.myPageDesignStackView.isHidden = false
//            myPageSettingView.inquiryButton.isHidden = false
            // ⭐ 택스트필드 6개 입력한 값들을 저장해서 파이어베이스에 넣어주기!
            guard let distanceText = myPageView.carTotalDistanceTextField.text else {
                return
            } // ⭐⭐⭐(Optional unwrapping) distanceText Text (String?)형태라서 nil 일수도 있어서... guard let으로 Optional unwrapping
            let changedCar = Car(number: myPageView.carNumberTextField.text, maker: myPageView.carMakerTextField.text, name: myPageView.carNameTextField.text, oilType: myPageView.carOilTypeTextField.text, nickName: myPageView.carNickNameTextField.text, totalDistance: Int(distanceText) ?? Int(0), userEmail: Constants.currentUser.userEmail)
            FirestoreService.firestoreService.saveCar(car: changedCar) { _ in
            }
            Constants.currentUser = changedCar
        }
    }
    
    private func setupUI() {
        view.addSubview(myPageView)
        myPageView.addSubview(myPageSettingView)
        
        myPageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        myPageSettingView.snp.makeConstraints { make in
            make.top.equalTo(myPageView.carTotalDistanceStackView.snp.bottom).offset(Constants.verticalMargin * 5)
            make.leading.trailing.equalTo(view)
        }
        
        FirestoreService.firestoreService.loadCar { carInfoArray in
            if let index = carInfoArray?.firstIndex(where: { $0.userEmail == Constants.currentUser.userEmail }) {
                if let car = carInfoArray?[index] {
                    if let userEmail = car.userEmail {
                        if let atIndex = userEmail.firstIndex(of: "@") {
                            let emailPrefix = String(userEmail[..<atIndex])
                            self.myPageView.mainTitleLabel.text = "\(emailPrefix) 님"
                        } else {
                            self.myPageView.mainTitleLabel.text = "\(userEmail) 님"
                        }
                        self.myPageView.carNumberTextField.text = car.number
                        self.myPageView.carMakerTextField.text = car.maker
                        self.myPageView.carNameTextField.text = car.name
                        self.myPageView.carOilTypeTextField.text = car.oilType
                        self.myPageView.carNickNameTextField.text = car.nickName
                        if let totalDistance = car.totalDistance {
                            self.myPageView.carTotalDistanceTextField.text = String(totalDistance)
                        } else {
                            self.myPageView.carTotalDistanceTextField.text = "0.0"
                        }
                    }
                }
            }
        }
    }
    
    @objc func logoutButtonTapped() {
        if Constants.currentUser != nil {
            let alert = UIAlertController(title: "로그아웃", message: "지금 로그아웃하시겠어요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
            present(alert, animated: true)
            alert.addAction(UIAlertAction(title: "로그아웃", style: .default, handler: { _ in
                LoginService.loginService.logout {
                    let loginViewController = LoginPageViewController()
                    self.dismiss(animated: true) {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let sceneDelegate = windowScene.delegate as? SceneDelegate
                        {
                            sceneDelegate.window?.rootViewController = loginViewController
                        }
                    }
                }
            }))
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc func quitUserButtonTapped() {
        if Constants.currentUser != nil {
            let alert = UIAlertController(title: "정말 탈퇴하시겠어요?", message: "탈퇴 버튼 선택 시, 계정은 삭제되며 복구되지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
            present(alert, animated: true)
            alert.addAction(UIAlertAction(title: "탈퇴하기", style: .default, handler: { _ in
                LoginService.loginService.quitUser(email: Constants.currentUser.userEmail ?? "") { _ in
                    let loginViewController = LoginPageViewController()
                    self.dismiss(animated: true) {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let sceneDelegate = windowScene.delegate as? SceneDelegate
                        {
                            sceneDelegate.window?.rootViewController = loginViewController
                        }
                    }
                }
            }))
        } else {
            dismiss(animated: true)
        }
    }
    
    func checkCarNumberButtonAction() {
        myPageView.carNumberTextField.addAction(UIAction(handler: { _ in
            self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
            self.myPageView.checkCarNumberButton.setTitle("중복확인", for: .normal)
            self.myPageView.checkCarNumberButton.backgroundColor = .mainNavyColor
        }), for: .editingChanged)
        myPageView.checkCarNumberButton.addAction(UIAction(handler: { _ in
            guard let carNumberToCheck = self.myPageView.carNumberTextField.text, !carNumberToCheck.isEmpty else {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
            }
            
            guard carNumberToCheck.isValidateCarNumber(carNumberToCheck) else {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
            }
            
            guard carNumberToCheck.count >= 7 else {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "7자리 이상 입력하세요", completion: {})
            }
            
            let fifthCharacterIndex = carNumberToCheck.index(carNumberToCheck.endIndex, offsetBy: -5)
            let fifthCharacter = carNumberToCheck[fifthCharacterIndex]
            
            if String(fifthCharacter).range(of: "[가-힣]+", options: .regularExpression) == nil {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "가운데 한글이 빠졌습니다", completion: {})
            }
            
            FirestoreService.firestoreService.checkDuplicate(car: carNumberToCheck, data: "number", completion: { isCarAvailable, error in
                if let error = error {
                    print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                    return
                }
                
                if isCarAvailable {
                    self.myPageView.checkCarNumberButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                    self.myPageView.checkCarNumberButton.setTitle("가능", for: .normal)
                    self.myPageView.checkCarNumberButton.backgroundColor = .mainNavyColor
                } else {
                    self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                    self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                    self.myPageView.checkCarNumberButton.backgroundColor = .red
                    self.showAlert(message: "이미 존재하는 차번호입니다", completion: {})
                    self.myPageView.carNumberTextField.text = ""
                }
            })
        }), for: .touchUpInside)
    }
    
    func checkNickNameButtonAction() {
        myPageView.carNickNameTextField.addAction(UIAction(handler: { _ in
            self.myPageView.checkCarNickNameButton.setTitleColor(.white, for: .normal)
            self.myPageView.checkCarNickNameButton.setTitle("중복확인", for: .normal)
            self.myPageView.checkCarNickNameButton.backgroundColor = .mainNavyColor
        }), for: .editingChanged)
        myPageView.checkCarNickNameButton.addAction(UIAction(handler: { _ in
            guard let nickNameToCheck = self.myPageView.carNickNameTextField.text, !nickNameToCheck.isEmpty else { return }
            
            FirestoreService.firestoreService.checkDuplicate(car: nickNameToCheck, data: "nickName", completion: { isCarAvailable, error in
                if let error = error {
                    print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                    return
                }
                
                if isCarAvailable {
                    self.myPageView.checkCarNickNameButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                    self.myPageView.checkCarNickNameButton.setTitle("가능", for: .normal)
                    self.myPageView.checkCarNickNameButton.backgroundColor = .mainNavyColor
                } else {
                    self.myPageView.checkCarNickNameButton.setTitleColor(.white, for: .normal)
                    self.myPageView.checkCarNickNameButton.setTitle("불가능", for: .normal)
                    self.myPageView.checkCarNickNameButton.backgroundColor = .red
                    self.myPageView.checkCarNickNameButton.backgroundColor = .buttonRedColor
                    self.showAlert(message: "이미 존재하는 닉네임입니다", completion: {})
                    self.myPageView.carNickNameTextField.text = ""
                }
            })
        }), for: .touchUpInside)
    }
    
    //    @objc private func dialPhoneNumber() { //전화 거는 메서드
    //        if let inquiryURL = URL(string: "tel://000-000-0000") {
    //            if UIApplication.shared.canOpenURL(inquiryURL) {
    //                UIApplication.shared.open(inquiryURL, options: [:], completionHandler: nil)
    //            } else {
    //                // 전화를 걸 수 없는 경우 오류 메세지 표시
    //                let alert = UIAlertController(title: "오류", message: "단말기에서 전화 통화를 지원하지 않습니다.", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
    //                present(alert, animated: true, completion: nil)
    //            }
    //        }
    //    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
            print("확인")
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    @objc private func sendEmailTapped() {
        
        if MFMailComposeViewController.canSendMail() {
            
            let compseViewController = MFMailComposeViewController()
            compseViewController.mailComposeDelegate = self
            
            compseViewController.setToRecipients(["carlog2313@gmail.com"])
            compseViewController.setSubject("신고/문의")
            compseViewController.setMessageBody("신고나 문의를 자세히 입력해 주세요!", isHTML: false)
            
            self.present(compseViewController, animated: true, completion: nil)
            
        }
        else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Mail compose error: \(error.localizedDescription)")
        }
        controller.dismiss(animated: true, completion: nil)
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
        myPageView.scrollView.contentInset = contentInset
        myPageView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        myPageView.scrollView.contentInset = contentInset
        myPageView.scrollView.scrollIndicatorInsets = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myPageView.endEditing(true)
    }
    
//    func showAlert(message: String) {
//        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    
}
