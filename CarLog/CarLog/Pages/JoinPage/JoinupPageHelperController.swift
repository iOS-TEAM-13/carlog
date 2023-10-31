//
//  TimerViewController.swift
//  CarLog
//
//  Created by 김은경 on 10/31/23.
//

import UIKit

// open 접근 제어자는 다른 모듈에서 상속하고 확장이 가능함
open class JoinupPageHelperController: UIViewController {
    var timer: Timer?
    var seconds: Int = 180
    var isCheckedEmail = false

    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    let carMakerView = CarMakerView()
    let carModelView = CarModelView()
    let oilModelView = OilModelView()
    let nickNameView = NickNameView()
    let totalDistanceView = TotalDistanceView()

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Timer 구현

    open func startTimer() { // 타이머 시작 함수
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }

    open func stopTimer() { // 타이머 중지 함수
        timer?.invalidate()
        timer = nil // 타이머 객체 해제
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    @objc func updateTimerLabel() {
        if seconds > 0 {
            seconds -= 1
            joinupView.smtpTimerLabel.text = timeString(time: TimeInterval(seconds))
        } else if seconds == 0 {
            joinupView.smtpTimerLabel.isHidden = true
            joinupView.verifiedEmailButton.isEnabled = true
            joinupView.verifiedEmailButton.backgroundColor = .mainNavyColor
            joinupView.verifiedEmailButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
            joinupView.smtpTimerLabel.text = "대기중"
            isCheckedEmail = false
            stopTimer()
        }
    }

    // MARK: - Alert 창 구현

    open func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard 관련

    open func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        let lists: [UIView] = [carNumberView, carModelView, nickNameView, totalDistanceView]
        let buttonLists: [UIView] = [carNumberView.nextButton, carModelView.nextButton, nickNameView.nextButton, totalDistanceView.nextButton]

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
        joinupView.scrollView.contentInset = contentInset
        joinupView.scrollView.scrollIndicatorInsets = contentInset

        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        {
            let keyboardHeight = keyboardFrame.height
            for buttonList in buttonLists {
                let textFieldFrameInWindow = buttonList.convert(buttonList.bounds, to: nil)
                let maxY = textFieldFrameInWindow.maxY
                for list in lists {
                    if maxY > (list.frame.size.height - keyboardHeight) {
                        let scrollOffset = maxY - (list.frame.size.height - keyboardHeight)
                        list.frame.origin.y = scrollOffset - 100
                    }
                }
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        joinupView.scrollView.contentInset = contentInset
        joinupView.scrollView.scrollIndicatorInsets = contentInset
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        joinupView.endEditing(true)
        carNumberView.endEditing(true)
        carModelView.endEditing(true)
        oilModelView.endEditing(true)
        nickNameView.endEditing(true)
        totalDistanceView.endEditing(true)
    }
}
