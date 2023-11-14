//
//  AlertView.swift
//  CarLog
//
//  Created by 김은경 on 11/14/23.
//

import UIKit

extension UIViewController {
    func showAlert(checkText: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: checkText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
          completion()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true, completion: nil)
      }

    func showAlert(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        })
        present(alert, animated: true, completion: nil)
    }
}
