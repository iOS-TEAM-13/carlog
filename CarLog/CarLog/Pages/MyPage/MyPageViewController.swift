import FirebaseAuth
import SnapKit
import UIKit

class MyPageViewController: UIViewController {
   
// MARK: - Properties
    let myPageView = MyPageView()
    var isEditMode = false
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

// MARK: - Setup
        view.addSubview(myPageView)
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addTargetButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        FirestoreService.firestoreService.loadCar(completion: <#T##([Car]?) -> Void#>)
//        // ⭐ 내 차 정보 불러오기
    }
    
    func addTargetButton() {
        myPageView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        myPageView.phoneCallButton.addTarget(self, action: #selector(dialPhoneNumber), for: .touchUpInside)
    }
    
    // MARK: - Actions
      @objc private func editButtonTapped() {
          isEditMode = !isEditMode
          toggleTextFieldsEditing(enable: isEditMode)
          editButtonChanged(editMode: isEditMode)
      }
      
      private func toggleTextFieldsEditing(enable: Bool) {
          [myPageView.carNumberTextField, myPageView.carTypeTextField, myPageView.carMakerTextField, myPageView.carOilTypeTextField].forEach {
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
            myPageView.myWritingButton.isHidden = true
            myPageView.myPageDesignStackView.isHidden = true
            myPageView.phoneCallButton.isHidden = true
        } else {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
            let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
            myPageView.editButton.setImage(image, for: .normal)
            myPageView.myWritingButton.isHidden = false
            myPageView.myPageDesignStackView.isHidden = false
            myPageView.phoneCallButton.isHidden = false
            // ⭐ 택스트필드1~4 입력한 값들을 저장해서 파이어베이스에 넣어주기!
            FirestoreService.firestoreService.saveCar(car: Car(number: myPageView.carNumberTextField.text, maker: myPageView.carMakerTextField.text, name: myPageView.carTypeTextField.text, oilType: myPageView.carOilTypeTextField.text, nickName: "", totalDistance: 0.0, userEmail: Auth.auth().currentUser?.email)) { error in
            }
        }
        
    }
    
    @objc func logoutButtonTapped() {
    LoginService.loginService.logout {
        self.dismiss(animated: true)
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
    
}
