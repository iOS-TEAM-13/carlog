import FirebaseAuth
import FirebaseFirestore
import SnapKit
import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    let myPageView = MyPageView()
    
    var carDummy: [Car] = []
    
    var isEditMode = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: - Setup
        view.addSubview(myPageView)
        myPageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        addTargetButton()
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
    }
    
    func addTargetButton() {
        myPageView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageView.quitUserButton.addTarget(self, action: #selector(quitUserButtonTapped), for: .touchUpInside)
        myPageView.phoneCallButton.addTarget(self, action: #selector(dialPhoneNumber), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func editButtonTapped() {
        isEditMode = !isEditMode
        toggleTextFieldsEditing(enable: isEditMode)
        editButtonChanged(editMode: isEditMode)
    }
    
    private func toggleTextFieldsEditing(enable: Bool) {
        [myPageView.carNumberTextField, myPageView.carNameTextField, myPageView.carMakerTextField, myPageView.carOilTypeTextField, myPageView.carNickNameTextField, myPageView.carTotalDistanceTextField].forEach {
            $0.isUserInteractionEnabled = enable
            $0.borderStyle = enable ? .roundedRect : .none   // 라운더 없음으로 해도 글씨 창 라운더 생김 현상(커스텀 때문인지;;)
        }
    }
    
    private func editButtonChanged(editMode: Bool) {
        if editMode {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "checkmark.circle", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            myPageView.editButton.setImage(image, for: .normal)
            //            myPageView.myWritingButton.isHidden = true
            myPageView.myPageDesignStackView.isHidden = true
            myPageView.phoneCallButton.isHidden = true
        } else {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            //            myPageView.myWritingButton.isHidden = false
            myPageView.myPageDesignStackView.isHidden = false
            myPageView.phoneCallButton.isHidden = false
            // ⭐ 택스트필드 6개 입력한 값들을 저장해서 파이어베이스에 넣어주기!
            guard let distanceText = myPageView.carTotalDistanceTextField.text else {
                return
            } // ⭐⭐⭐(Optional unwrapping) distanceText Text (String?)형태라서 nil 일수도 있어서... guard let으로 Optional unwrapping
            FirestoreService.firestoreService.saveCar(car: Car(number: myPageView.carNumberTextField.text, maker: myPageView.carMakerTextField.text, name: myPageView.carNameTextField.text, oilType: myPageView.carOilTypeTextField.text, nickName: myPageView.carNickNameTextField.text, totalDistance: Int(distanceText) ?? Int(0), userEmail: Auth.auth().currentUser?.email)) { error in
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
            [UIAlertAction(title: "탈퇴하기", style: .default),
             UIAlertAction(title: "취소", style: .cancel)].forEach{alert.addAction($0)}; present(alert, animated: true)
            // 회원탈퇴 하기전, alert 창에 확인버튼으로 감싸기
            LoginService.loginService.quitUser(email: Auth.auth().currentUser?.email ?? "") { error in
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
    
    @objc private func dialPhoneNumber() {
        if let phoneCallURL = URL(string: "tel://000-000-0000") {
            if UIApplication.shared.canOpenURL(phoneCallURL) {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                // 전화를 걸 수 없는 경우 오류 메세지 표시
                let alert = UIAlertController(title: "오류", message: "단말기에서 전화 통화를 지원하지 않습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
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
}
