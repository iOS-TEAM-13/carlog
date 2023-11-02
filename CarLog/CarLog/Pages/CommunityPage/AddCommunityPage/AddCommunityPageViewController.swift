//
//  AddCommunityPageViewController.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/11/01.
//

import FirebaseAuth
import SnapKit
import SwiftUI
import UIKit

class AddCommunityPageViewController: UIViewController {
    let addCommunityPageView = AddCommunityPageView()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        return imageView
    }()

    let chooseImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose Image", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)

        return button
    }()

    let uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addTarget()

        view.addSubview(addCommunityPageView)
        view.addSubview(imageView)
        view.addSubview(chooseImageButton)
        view.addSubview(uploadButton)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }

        chooseImageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(chooseImageButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }

    func addTarget() {
        chooseImageButton.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
         uploadButton.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
    }

    @objc func chooseImage() {
        // 이미지를 선택하고 imageView에 표시하는 로직을 여기에 추가
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // 사진첩을 열도록 설정
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func uploadImage() {
        guard let user = Auth.auth().currentUser else { return }
                guard let selectedImage = imageView.image else { return }
                StorageService.storageService.uploadImage(image: selectedImage, pathRoot: user.uid) { url in }
    }

    // SwiftUI를 활용한 미리보기
    struct AddCommunityPageViewController_Previews: PreviewProvider {
        static var previews: some View {
            AddCommunityPageVCReprsentable().edgesIgnoringSafeArea(.all)
        }
    }

    struct AddCommunityPageVCReprsentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let addCommunityPageVC = AddCommunityPageViewController()
            return UINavigationController(rootViewController: addCommunityPageVC)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        typealias UIViewControllerType = UIViewController
    }
}

extension AddCommunityPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
//            uploadButton.addAction(UIAction(handler: { _ in
//                guard let user = Auth.auth().currentUser else { return }
//                StorageService.storageService.uploadImage(image: selectedImage, pathRoot: user.uid) { url in }
//            }), for: .touchUpInside)
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 선택을 취소했을 때 실행할 작업을 구현
        dismiss(animated: true, completion: nil)
    }
}
