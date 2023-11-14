import UIKit

import FirebaseAuth
import FirebaseFirestore
import SnapKit

class JoinupPageViewController: JoinupPageHelperController {
    var isChecked = false
    let dummyData = ["휘발유", "경유", "LPG"]

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor

        joinupView.buttonStackView.firstButton.isEnabled = false
        carNumberView.textField.delegate = self

        setupUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        view.addSubview(joinupView) // 첫 view
        forHiddenViews() // 다음 버튼들의 숨겨진 views
        registerForKeyboardNotifications() // 키보드 기능들
        addTargets() // 기능 구현 한 곳

        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addTargets() {
        addJoinUserFieldActions()
        addCheckEmailButtonAction()
        addSMTPButtonAction()
        addSMTPNumberButtonAction()
        addJoinInButtonAction()
        personalInfoVerifiedCheck()
        checkCarNumberButtonAction()
        CheckNickNameButtonAction()
    }

    // MARK: - 모든 뷰들

    private func forHiddenViews() {
        joinupView.buttonStackView.secondButton.addAction(UIAction(handler: { _ in
            self.showAlert(checkText: "회원가입을\n취소하시겠습니까?") { self.dismiss(animated: true) }
        }), for: .touchUpInside)

        carNumberView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            guard self.carNumberView.button.title(for: .normal) == "가능" else {
                self.showAlert(message: "중복확인을 해주세요\nex)00가0000", completion: {})
                return
            }
            self.view.addSubview(self.carMakerView)
            self.carNumberView.isHidden = true
            self.carMakerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        carNumberView.nextButton.secondButton.isHidden = true

        carMakerView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carModelView)
            self.carMakerView.isHidden = true
            self.carModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        carMakerView.nextButton.secondButton.isHidden = true

        carModelView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.oilModelView)
            self.carModelView.isHidden = true
            self.oilModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        carModelView.nextButton.secondButton.isHidden = true

        oilModelView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.nickNameView)
            self.oilModelView.isHidden = true
            self.nickNameView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        oilModelView.nextButton.secondButton.isHidden = true

        nickNameView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            guard self.nickNameView.button.title(for: .normal) == "가능" else {
                self.showAlert(message: "중복확인을 해주세요", completion: {})
                return
            }
            self.view.addSubview(self.totalDistanceView)
            self.nickNameView.isHidden = true
            self.totalDistanceView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        nickNameView.nextButton.secondButton.isHidden = true

        totalDistanceView.nextButton.firstButton.addAction(UIAction(handler: { _ in
            let selectedOilType = self.oilModelView.selectedOil
            LoginService.loginService.signUpUser(email: self.joinupView.emailTextField.text ?? "", password: self.joinupView.passwordTextField.text ?? "") {
                FirestoreService.firestoreService.saveCar(
                    car: Car(
                        number: self.carNumberView.textField.text,
                        maker: self.carMakerView.textField.text,
                        name: self.carModelView.textField.text,
                        oilType: selectedOilType ?? "",
                        nickName: self.nickNameView.textField.text,
                        totalDistance: Int(self.totalDistanceView.textField.text ?? "") ?? 0,
                        userEmail: self.joinupView.emailTextField.text),
                    completion: { _ in
                        self.doneButtonTapped()
                    })
            }
        }), for: .touchUpInside)

        totalDistanceView.nextButton.secondButton.isHidden = true
    }

    // 최종 주행거리 "완료" 버튼
    private func doneButtonTapped() {
        showAlert(message: "회원가입을 완료하였습니다") {
            LoginService.loginService.keepLogin { user in
                if user != nil {
                    let tabBarController = Util.mainTabBarController()
                    if let windowScene = UIApplication.shared.connectedScenes
                        .first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                        let window = windowScene.windows.first
                    {
                        window.rootViewController = tabBarController
                    }
                }
            }
        }
    }
}
