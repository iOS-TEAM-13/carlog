//
//  AddCommunityPageViewController.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/11/01.
//

import SnapKit
import PhotosUI
import UIKit


class AddCommunityPageViewController: UIViewController {
    
    private let mainTitleLabel: UILabel = {
        let mainTitleLabel = UILabel()
        mainTitleLabel.text = "제목"
        mainTitleLabel.textColor = .black
        mainTitleLabel.backgroundColor = .white
        mainTitleLabel.layer.borderColor = UIColor.clear.cgColor
        mainTitleLabel.layer.borderWidth = 0
        mainTitleLabel.layer.cornerRadius = 15
        mainTitleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        mainTitleLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return mainTitleLabel
    }()
    
    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "본문"
        subTitleLabel.textColor = .black
        subTitleLabel.backgroundColor = .white
        subTitleLabel.layer.borderColor = UIColor.clear.cgColor
        subTitleLabel.layer.borderWidth = 0
        subTitleLabel.layer.cornerRadius = 15
        //        subTitleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        subTitleLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return subTitleLabel
    }()
    
    private let imagePickerView = UIImageView()
    private let imagePickerButton = UIButton()
    private let numberOfSelectedImageLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let separatorView = UIView()
    private let optionsTableView = UITableView()
    //    private let activityIndicatorView = UIActivityIndicatorView()
    
    private var selectedImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        attribute()
        setupUI()
        
    }
    
}

extension AddCommunityPageViewController {
    @objc func didTapLeftBarButton() {
        dismiss(animated: true)
    }
    @objc func didTapRightBarButton() {
        print("didTapRightBarButton is Called!")
        
        //                activityIndicatorView.startAnimating()
        
        view.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func didTapImagePickerButton() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selection = .ordered
        config.selectionLimit = 5
        let imagePickerViewController = PHPickerViewController(configuration: config)
        //    imagePickerViewController.delegate = self
        //    present(imagePickerViewController, animated: true)
    }
}

private extension AddCommunityPageViewController {
    func attribute() {
        view.backgroundColor = .systemRed
        
        imagePickerView.backgroundColor = .systemBlue
        imagePickerView.layer.cornerRadius = 15
        imagePickerButton.addTarget(
            self,
            action: #selector(didTapImagePickerButton),
            for: .touchUpInside
        )
        numberOfSelectedImageLabel.text = "\(selectedImages.count)"
        numberOfSelectedImageLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        numberOfSelectedImageLabel.textColor = .white
        numberOfSelectedImageLabel.textAlignment = .center
        numberOfSelectedImageLabel.backgroundColor = .systemBlue
        numberOfSelectedImageLabel.clipsToBounds = true
        numberOfSelectedImageLabel.layer.cornerRadius = 12.0
    }
    
    func setupUI() {
        let commonInset: CGFloat = 16.0
        [
            mainTitleLabel,
            subTitleLabel,
            imagePickerView,
            imagePickerButton,
            numberOfSelectedImageLabel,
            descriptionTextView,
            separatorView,
            optionsTableView,
        ].forEach { view.addSubview($0) }
        
        
        //         snap kit 제약 잡기
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(commonInset)
            make.top.equalTo(view.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(100)
        }
        
        imagePickerView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(commonInset)
            make.size.equalTo(100)
        }
        
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.widthAnchor.constraint(
            equalTo: imagePickerView.widthAnchor
        ).isActive = true
        imagePickerButton.heightAnchor.constraint(
            equalTo: imagePickerView.heightAnchor
        ).isActive = true
        imagePickerButton.centerXAnchor.constraint(
            equalTo: imagePickerView.centerXAnchor
        ).isActive = true
        imagePickerButton.centerYAnchor.constraint(
            equalTo: imagePickerView.centerYAnchor
        ).isActive = true
        
        numberOfSelectedImageLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfSelectedImageLabel.widthAnchor.constraint(
            equalToConstant: 24.0
        ).isActive = true
        numberOfSelectedImageLabel.heightAnchor.constraint(
            equalToConstant: 24.0
        ).isActive = true
        numberOfSelectedImageLabel.topAnchor.constraint(
            equalTo: imagePickerView.topAnchor,
            constant: -8.0
        ).isActive = true
        numberOfSelectedImageLabel.trailingAnchor.constraint(
            equalTo: imagePickerView.trailingAnchor,
            constant: 8.0
        ).isActive = true
        
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "새 게시물"
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        let rightBarButtonItem = UIBarButtonItem(
            title: "공유",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        leftBarButtonItem.tintColor = .label
        rightBarButtonItem.tintColor = .systemBlue
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}
