//
//  AddCommunityPageViewController.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/11/01.
//

import UIKit
import SnapKit
import SwiftUI

class AddCommunityPageViewController: UIViewController {
    
    let addCommunityPageView = AddCommunityPageView()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()

    let chooseImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose Image", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        return button
    }()

    let uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

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

    @objc func chooseImage() {
        // 이미지를 선택하고 imageView에 표시하는 로직을 여기에 추가
    }

    @objc func uploadImage() {
        // 선택한 이미지를 업로드하는 로직을 여기에 추가
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
