import UIKit

import FirebaseAuth
import FirebaseFirestore
import MessageUI
import SnapKit

class MyPageViewController: UIViewController, MFMailComposeViewControllerDelegate {
    // MARK: - Properties
    
    let myPageView = MyPageView()
    
    var carDummy: [Car] = []
    
    var isEditMode = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        //        self.navigationController?.isNavigationBarHidden = true
        
        // MARK: - Setup
        
        view.addSubview(myPageView)
        myPageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
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
        
        DispatchQueue.main.async {
            self.loadCarData() // ⭐ 내 차 정보 가져오기
        }
        
        if isEditMode {
            toggleTextFieldsEditing(enable: false)
            editButtonChanged(editMode: false)
        }
        
    }
    
    func addTargetButton() {
        myPageView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        myPageView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageView.quitUserButton.addTarget(self, action: #selector(quitUserButtonTapped), for: .touchUpInside)
        //        myPageView.inquiryButton.addTarget(self, action: #selector(dialPhoneNumber), for: .touchUpInside)
        myPageView.inquiryButton.addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func editButtonTapped() {
        isEditMode = !isEditMode
        toggleTextFieldsEditing(enable: isEditMode)
        editButtonChanged(editMode: isEditMode)
    }
    
    @objc private func cancelButtonTapped() {
        // 취소 버튼,현재 입력된 내용을 초기값으로 설정
        myPageView.carNumberTextField.text = carDummy.first?.number
        myPageView.carNameTextField.text = carDummy.first?.name
        myPageView.carMakerTextField.text = carDummy.first?.maker
        myPageView.carOilTypeTextField.text = carDummy.first?.oilType
        myPageView.carNickNameTextField.text = carDummy.first?.nickName
        if let totalDistance = carDummy.first?.totalDistance {
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
            myPageView.myPageDesignStackView.isHidden = true
            myPageView.inquiryButton.isHidden = true
        } else {
            guard let checkCarNumber = self.myPageView.carNumberTextField.text,
                  let checkCarNickName = self.myPageView.carNickNameTextField.text
            else {
                return
            }
            // 조건을 만족하지 않을 때 경고 표시
            if checkCarNumber.isEmpty {
                self.showAlert(message: "00가0000 형식으로 써주세요")
                return
            } else if checkCarNickName.isEmpty {
                self.showAlert(message: "닉네임을 꼭 작성해 주세요")
                return
            }
            
            
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            myPageView.cancelButton.isHidden = true
            //            myPageView.myWritingButton.isHidden = false
            myPageView.checkCarNumberButton.isHidden = true
            myPageView.checkCarNickNameButton.isHidden = true
            myPageView.myPageDesignStackView.isHidden = false
            myPageView.inquiryButton.isHidden = false
            // ⭐ 택스트필드 6개 입력한 값들을 저장해서 파이어베이스에 넣어주기!
            guard let distanceText = myPageView.carTotalDistanceTextField.text else {
                return
            } // ⭐⭐⭐(Optional unwrapping) distanceText Text (String?)형태라서 nil 일수도 있어서... guard let으로 Optional unwrapping
            FirestoreService.firestoreService.saveCar(car: Car(number: myPageView.carNumberTextField.text, maker: myPageView.carMakerTextField.text, name: myPageView.carNameTextField.text, oilType: myPageView.carOilTypeTextField.text, nickName: myPageView.carNickNameTextField.text, totalDistance: Int(distanceText) ?? Int(0), userEmail: Auth.auth().currentUser?.email)) { _ in
            }
        }
    }
    
    private func configureUI() {
        if let userCar = carDummy.first { // 배열에서 첫 번째 요소 가져오기
            if let userEmail = userCar.userEmail {
                if let atIndex = userEmail.firstIndex(of: "@") {
                    let emailPrefix = String(userEmail[..<atIndex])
                    myPageView.mainTitleLabel.text = "\(emailPrefix) 님"
                } else {
                    myPageView.mainTitleLabel.text = "\(userEmail) 님"
                }
            }
            myPageView.carNumberTextField.text = userCar.number
            myPageView.carMakerTextField.text = userCar.maker
            myPageView.carNameTextField.text = userCar.name // name 으로 통일!
            myPageView.carOilTypeTextField.text = userCar.oilType
            myPageView.carNickNameTextField.text = userCar.nickName
            if let totalDistance = userCar.totalDistance {
                myPageView.carTotalDistanceTextField.text = String(totalDistance)
            } else {
                myPageView.carTotalDistanceTextField.text = "0.0" // 만약 totalDistance가 nil인 경우 기본값 설정
            }
        } else {
            // carDummy 배열이 비어있을 때 대응할 내용을 여기에 추가할 수 있습니다.
        }
    }
    
    @objc func logoutButtonTapped() {
        if Auth.auth().currentUser != nil {
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
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc func quitUserButtonTapped() {
        if Auth.auth().currentUser != nil {
            let alert = UIAlertController(title: "정말 탈퇴하시겠어요?", message: "탈퇴 버튼 선택 시, 계정은 삭제되며 복구되지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "탈퇴하기", style: .default, handler: { _ in
                LoginService.loginService.quitUser(email: Auth.auth().currentUser?.email ?? "") { _ in
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
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
            present(alert, animated: true)
            // 회원탈퇴 하기전, alert 창에 확인버튼으로 감싸기
            
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
                return self.showAlert(message: "00가0000 형식으로 써주세요")
            }
            
            guard carNumberToCheck.isValidateCarNumber(carNumberToCheck) else {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "00가0000 형식으로 써주세요")
            }
            
            guard carNumberToCheck.count >= 7 else {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "7자리 이상 입력하세요")
            }
            
            let fifthCharacterIndex = carNumberToCheck.index(carNumberToCheck.endIndex, offsetBy: -5)
            let fifthCharacter = carNumberToCheck[fifthCharacterIndex]
            
            if String(fifthCharacter).range(of: "[가-힣]+", options: .regularExpression) == nil {
                self.myPageView.checkCarNumberButton.setTitleColor(.white, for: .normal)
                self.myPageView.checkCarNumberButton.setTitle("불가능", for: .normal)
                self.myPageView.checkCarNumberButton.backgroundColor = .red
                self.myPageView.carNumberTextField.text = ""
                return self.showAlert(message: "가운데 한글이 빠졌습니다")
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
                    self.showAlert(message: "이미 존재하는 차번호입니다")
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
                    self.showAlert(message: "이미 존재하는 닉네임입니다")
                    self.myPageView.carNickNameTextField.text = ""
                }
            })
        }), for: .touchUpInside)
    }
    
    //    @objc private func dialPhoneNumber() {
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
            
            compseViewController.setToRecipients(["carlog2310@gmail.com"])
            compseViewController.setSubject("신고/문의")
            compseViewController.setMessageBody("Message Content", isHTML: false)
            
            self.present(compseViewController, animated: true, completion: nil)
            
        }
        else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func loadCarData() {
        FirestoreService.firestoreService.loadCar { result in
            if let car = result {
                self.carDummy = car
                self.configureUI()
            } else {
                print("데이터 로드 중 오류 발생")
            }
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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
