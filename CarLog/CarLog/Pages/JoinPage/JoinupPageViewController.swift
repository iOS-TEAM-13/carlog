import UIKit

import FirebaseAuth
import FirebaseDatabase
import SnapKit

class JoinupPageViewController: UIViewController {
    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    let carModelView = CarModelView()
    let oilModelView = OilModelView()
    let nickNameView = NickNameView()
    let totalDistanceView = TotalDistanceView()

    let dummyData = ["휘발유", "경유", "LPG"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        oilModelView.oilCollectionView.register(OilModelCollectionViewCell.self, forCellWithReuseIdentifier: "oilModelCollectionViewCell")
        oilModelView.oilCollectionView.dataSource = self
        oilModelView.oilCollectionView.delegate = self
        oilModelView.oilCollectionView.reloadData()

        setupUI()
    }

    func setupUI() {
        view.addSubview(joinupView) // 첫번째 화면 뷰

        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        joinupView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        joinupView.checkEmailButton.addTarget(self, action: #selector(checkEmailButtonTapped), for: .touchUpInside)
        joinupView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        joinupView.confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        joinupView.joinInButton.addTarget(self, action: #selector(joinInButtonTapped), for: .touchUpInside)
        joinupView.popButton.addTarget(self, action: #selector(joininPopButtonTapped), for: .touchUpInside)
        carNumberView.popButton.addTarget(self, action: #selector(carNumberViewPopButtonTapped), for: .touchUpInside)
        carNumberView.nextButton.addTarget(self, action: #selector(carNumberViewPopNextButtonTapped), for: .touchUpInside)
        carModelView.popButton.addTarget(self, action: #selector(carModelViewPopButtonTapped), for: .touchUpInside)
        carModelView.nextButton.addTarget(self, action: #selector(carModelViewNextButtonTapped), for: .touchUpInside)
        oilModelView.popButton.addTarget(self, action: #selector(oilViewPopButtonTapped), for: .touchUpInside)
        oilModelView.nextButton.addTarget(self, action: #selector(oilViewNextButtonTapped), for: .touchUpInside)
        nickNameView.popButton.addTarget(self, action: #selector(nickNameViewPopButtonTapped), for: .touchUpInside)
        nickNameView.nextButton.addTarget(self, action: #selector(nickNameViewNextButtonTapped), for: .touchUpInside)
        totalDistanceView.popButton.addTarget(self, action: #selector(totalDistanceViewPopButtonTapped), for: .touchUpInside)
        totalDistanceView.nextButton.addTarget(self, action: #selector(totalDistanceViewNextButtonTapped), for: .touchUpInside)
    }
}

extension JoinupPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oilModelView.oilCollectionView.dequeueReusableCell(withReuseIdentifier: "oilModelCollectionViewCell", for: indexPath) as! OilModelCollectionViewCell
        cell.label.text = dummyData[indexPath.item]
        return cell
    }
}

extension JoinupPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
}

extension JoinupPageViewController {
    @objc func textFieldDidChange() {}

    @objc func checkEmailButtonTapped() {
        checkEmailDuplication(email: joinupView.emailTextField.text ?? "?") { isDuplicate, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if isDuplicate {
                    self.joinupView.checkEmailButton.setTitle("완료", for: .normal)
                } else {
                    print("이메일이 이미 사용 중입니다.")
                    self.showEmailAlreadyInUseAlert()
                }
            }
        }
    }

    func showEmailAlreadyInUseAlert() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = "이메일이 이미 사용 중입니다."
        toastLabel.font = UIFont.systemFont(ofSize: 16)
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let toastHeight: CGFloat = 40
        let xOffset: CGFloat = 20
        let yOffset: CGFloat = 20

        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            // Safe area inset을 사용하여 위치 계산
            let safeArea = window.safeAreaInsets
            toastLabel.frame = CGRect(x: xOffset, y: window.frame.height - safeArea.top - yOffset - toastHeight, width: window.frame.width - 2 * xOffset, height: toastHeight)
            window.addSubview(toastLabel)

            UIView.animate(withDuration: 3.0, delay: 0.6, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }

    func checkEmailDuplication(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            if let error = error {
                print("Error checking email duplication: \(error.localizedDescription)")
                completion(false, error)
                return
            }

            if let signInMethods = methods, signInMethods.isEmpty {
                // 이메일이 이미 사용 중이지 않음
                completion(true, nil)
            } else {
                // 이메일이 이미 사용 중
                completion(false, nil)
            }
        }
    }

    @objc func joinInButtonTapped() {
        // 유효성 검사를 위한 입력 값 가져오기
        guard let email = joinupView.emailTextField.text,
              let password = joinupView.passwordTextField.text,
              let confirmPassword = joinupView.confirmPasswordTextField.text
        else {
            return
        }

        let isEmailValid = email.isValidEmail()
        let isPasswordValid = password.isValidPassword()
        let isConfirmPasswordValid = confirmPassword == password

        if isEmailValid, isPasswordValid, isConfirmPasswordValid {
            // 모든 조건을 만족하면 다음 단계로 이동
            view.addSubview(carNumberView)
            joinupView.isHidden = true
            carNumberView.isHidden = false
            carNumberView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            // 조건을 만족하지 않을 때 경고 표시
            var alertMessage = ""
            if !isEmailValid {
                alertMessage = "올바른 이메일 형식으로 써주세요"
            } else if !isPasswordValid {
                alertMessage = "올바른 비밀번호를 써주세요 (대/소문자,특수기호,8글자이상)"
            } else if !isConfirmPasswordValid {
                alertMessage = "비밀번호와 다릅니다, 다시 입력해주세요"
            }
            showAlert(message: alertMessage)
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc func joininPopButtonTapped() {
        dismiss(animated: true)
    }

    @objc func carNumberViewPopButtonTapped() {
        joinupView.isHidden = false
        carNumberView.isHidden = true
    }

    @objc func carNumberViewPopNextButtonTapped() {
        view.addSubview(carModelView)
        carNumberView.isHidden = true
        carModelView.isHidden = false
        carModelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func carModelViewPopButtonTapped() {
        carNumberView.isHidden = false
        carModelView.isHidden = true
    }

    @objc func carModelViewNextButtonTapped() {
        view.addSubview(oilModelView)
        carModelView.isHidden = true
        oilModelView.isHidden = false
        oilModelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func oilViewPopButtonTapped() {
        carModelView.isHidden = false
        oilModelView.isHidden = true
    }

    @objc func oilViewNextButtonTapped() {
        view.addSubview(nickNameView)
        oilModelView.isHidden = true
        nickNameView.isHidden = false
        nickNameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func nickNameViewPopButtonTapped() {
        oilModelView.isHidden = false
        nickNameView.isHidden = true
    }

    @objc func nickNameViewNextButtonTapped() {
        view.addSubview(totalDistanceView)
        nickNameView.isHidden = true
        totalDistanceView.isHidden = false
        totalDistanceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func totalDistanceViewPopButtonTapped() {
        nickNameView.isHidden = false
        totalDistanceView.isHidden = true
    }

    @objc func totalDistanceViewNextButtonTapped() {
        Auth.auth().createUser(withEmail: joinupView.emailTextField.text!, password: joinupView.passwordTextField.text!) { _, _ in
            let uid = Auth.auth().currentUser?.uid

            Database.database().reference().child("users").child(uid!).setValue(["name": self.nickNameView.carNickNameTextField.text])
            self.dismiss(animated: true)
        }
    }
}
