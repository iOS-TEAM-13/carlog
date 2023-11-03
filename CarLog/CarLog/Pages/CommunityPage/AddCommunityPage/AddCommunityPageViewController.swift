

import UIKit

import FirebaseAuth
import FirebaseStorage
import PhotosUI
import SnapKit

class AddCommunityPageViewController: UIViewController {
    let currentDate = Date()

    // MARK: -
    private let imagePickerView = UIImageView()
    private let imagePickerButton = UIButton()
    private let numberOfSelectedImageLabel = UILabel()
    private var selectedImages = [UIImage]()
    
    private let mainTextField: UITextField = {
        let mainTextField = UITextField()
        mainTextField.placeholder = "제목"
        mainTextField.textColor = .black
        mainTextField.backgroundColor = .white
        mainTextField.layer.borderColor = UIColor.clear.cgColor
        mainTextField.layer.borderWidth = 0
        mainTextField.layer.cornerRadius = 15
        mainTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mainTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: mainTextField.frame.size.height))
        mainTextField.leftViewMode = .always
        mainTextField.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return mainTextField
    }()

    private lazy var subTextView: UITextView = {
        let subTextView = UITextView()
        subTextView.text = " 문구 입력..."
        subTextView.textColor = .black
        subTextView.backgroundColor = .white
        subTextView.layer.borderColor = UIColor.clear.cgColor
        subTextView.layer.borderWidth = 0
        subTextView.layer.cornerRadius = 15
        subTextView.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        subTextView.delegate = self
        return subTextView
    }()

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        attribute()
        setupUI()
    }
}

extension AddCommunityPageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty {
            selectedImages = []
            results.forEach { result in
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self else { return }
                        if let image = image as? UIImage {
                            self.selectedImages.append(image)
                            DispatchQueue.main.async {
                                self.imagePickerView.image = image
                                self.numberOfSelectedImageLabel.text = "\(self.selectedImages.count)"
                            }
                        }
                        if error != nil {
                            print("ERROR")
                        }
                    }
                }
            }
        }
        dismiss(animated: true)
    }
}

// :star:️ navigation barButtons
extension AddCommunityPageViewController {
    @objc func didTapLeftBarButton() {
        dismiss(animated: true)
    }

    @objc func didTapRightBarButton() {
        let timeStamp = String.dateFormatter.string(from: currentDate)
        guard let user = Auth.auth().currentUser else { return }
        let dispatchGroup = DispatchGroup()
        var imageURLs: [URL] = []
        
        for i in selectedImages {
            dispatchGroup.enter()
            StorageService.storageService.uploadImage(image: i) { url in
                if let url = url {
                    imageURLs.append(url)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) { [self] in
            let post = Post(id: UUID().uuidString, title: self.mainTextField.text, content: subTextView.text, image: imageURLs, userEmail: user.email, timeStamp: timeStamp)
            FirestoreService.firestoreService.savePosts(post: post) { error in
                print("err: \(String(describing: error?.localizedDescription))")
            }
        }
        view.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc func didTapImagePickerButton() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selection = .ordered
        config.selectionLimit = 3
        // 사진 선택 리미티드
        let imagePickerViewController = PHPickerViewController(configuration: config)
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true)
    }
}

// :star:️ UITextViewDelegate
extension AddCommunityPageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ subTextView: UITextView) {
        if subTextView.textColor == .secondaryLabel {
            subTextView.textColor = .label
            subTextView.text = ""
        }
    }

    func textViewDidEndEditing(_ subTextView: UITextView) {
        if subTextView.text == "" {
            subTextView.textColor = .secondaryLabel
            subTextView.text = "문구 입력..."
        }
    }
}

private extension AddCommunityPageViewController {
    func attribute() {
        view.backgroundColor = .systemGray6
        imagePickerView.backgroundColor = .white
        imagePickerView.layer.cornerRadius = 15
        imagePickerButton.addTarget(
            self,
            action: #selector(didTapImagePickerButton),
            for: .touchUpInside
        )
        numberOfSelectedImageLabel.text = "\(selectedImages.count)"
        numberOfSelectedImageLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        numberOfSelectedImageLabel.textColor = .white
        numberOfSelectedImageLabel.textAlignment = .center
        numberOfSelectedImageLabel.backgroundColor = .mainNavyColor
        numberOfSelectedImageLabel.clipsToBounds = true
        numberOfSelectedImageLabel.layer.cornerRadius = 12.0
    }

    // MARK: -

    func setupUI() {
        [
            mainTextField,
            subTextView,
            imagePickerView,
            imagePickerButton,
            numberOfSelectedImageLabel
        ].forEach { view.addSubview($0) }
        mainTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.horizontalMargin)
        }
        subTextView.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(300)
        }
        imagePickerView.snp.makeConstraints { make in
            make.top.equalTo(subTextView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin)
            //      make.trailing.equalToSuperview().offset(-Constants.horizontalMargin)
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
        rightBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
