import UIKit

import FirebaseAuth
import FirebaseFirestore
import SnapKit

class JoinupPageViewController: JoinupPageHelperController {
    var isChecked = false
    let dummyData = ["휘발유", "경유", "LPG"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        joinupView.joinInButton.isEnabled = false
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
        CheckCarNumberButtonAction()
    }

    // MARK: - 모든 뷰들
    private func forHiddenViews() {
        joinupView.popButton.addAction(UIAction(handler: { _ in
            let alert = UIAlertController(title: nil, message: "회원가입을\n취소하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        carNumberView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carMakerView)
            self.carNumberView.isHidden = true
            self.carMakerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        carMakerView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carModelView)
            self.carMakerView.isHidden = true
            self.carModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        carModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.oilModelView)
            self.carModelView.isHidden = true
            self.oilModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        oilModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.nickNameView)
            self.oilModelView.isHidden = true
            self.nickNameView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        nickNameView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.totalDistanceView)
            self.nickNameView.isHidden = true
            self.totalDistanceView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        totalDistanceView.nextButton.addAction(UIAction(handler: { _ in
            let selectedOilType = self.oilModelView.selectedOil
            
            FirestoreService.firestoreService.saveCar(
                car: Car(
                    number: self.carNumberView.carNumberTextField.text,
                    maker: self.carMakerView.carMakerTextField.text,
                    name: self.carModelView.carModelTextField.text,
                    oilType: selectedOilType ?? "",
                    nickName: self.nickNameView.carNickNameTextField.text,
                    totalDistance: Int(self.totalDistanceView.totalDistanceTextField.text ?? "") ?? 0,
                    userEmail: self.joinupView.emailTextField.text),
                completion: { _ in
                    self.doneButtonTapped()
                })
        }), for: .touchUpInside)
    }
   
    //최종 주행거리 "완료" 버튼
    private func doneButtonTapped() {
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
