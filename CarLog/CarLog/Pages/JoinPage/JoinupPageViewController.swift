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
    @objc func textFieldDidChange() {
        
    }

    @objc func joinInButtonTapped() {
        // 유효성 검사를 위한 입력 값 가져오기
           guard let email = joinupView.emailTextField.text,
                 let password = joinupView.passwordTextField.text,
                 let confirmPassword = joinupView.confirmPasswordTextField.text
           else {
               showAlert(message: "모든 빈칸을 채워주세요.")
               return
           }

           let isEmailValid = email.isValidEmail()
           let isPasswordValid = password.isValidPassword()
           let isConfirmPasswordValid = confirmPassword == password

           if isEmailValid && isPasswordValid && isConfirmPasswordValid {
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
                   alertMessage += "유효한 이메일이 아닙니다. "
               }
               if !isPasswordValid {
                   alertMessage += "유효한 비밀번호가 아닙니다. "
               }
               if !isConfirmPasswordValid {
                   alertMessage += "비밀번호와 비밀번호 확인이 다릅니다. "
               }
               showAlert(message: alertMessage)
           }
    } // 회원가입 페이지 버튼

    func showAlert(message: String) {
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
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
