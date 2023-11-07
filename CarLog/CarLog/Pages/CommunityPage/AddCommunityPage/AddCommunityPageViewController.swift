import UIKit

import FirebaseAuth
import FirebaseStorage
import PhotosUI
import SnapKit

class AddCommunityPageViewController: UIViewController {
    let currentDate = Date()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .backgroundCoustomColor
        return scrollView
    }()
    
    private let contenView: UIView = {
        let contenView = UIView()
        contenView.backgroundColor = .buttonSkyBlueColor
        return contenView
    }()
    
    // MARK: -
    private let imagePickerView = UIImageView()
    private let secondImageView = UIImageView()
    private let thirdImageView = UIImageView()
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
        mainTextField.layer.cornerRadius = 5
        mainTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mainTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: mainTextField.frame.size.height))
        mainTextField.leftViewMode = .always
        mainTextField.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return mainTextField
    }()
    
    private let subTextViewPlaceHolder = "택스트를 입력하세요"
    lazy var subTextView: UITextView = {
        let subTextView = UITextView()
        subTextView.textColor = .black
        subTextView.backgroundColor = .white
        subTextView.layer.borderColor = UIColor.clear.cgColor
        subTextView.layer.borderWidth = 0
        subTextView.layer.cornerRadius = 3
        subTextView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        subTextView.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        subTextView.delegate = self
        return subTextView
    }()
    
    lazy var imagePickerStackView: UIStackView = {
        let imagePickerStackView = UIStackView()
        imagePickerStackView.axis = .horizontal
        imagePickerStackView.spacing = 10
        imagePickerStackView.distribution = .fillEqually
        return imagePickerStackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        attribute()
        setupUI()
        
        //        checkCameraPermission()
        //        checkAlbumPermission()
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        
        [
            mainTextField,
            subTextView,
            imagePickerView,
            imagePickerStackView,
            imagePickerButton,
            numberOfSelectedImageLabel
        ].forEach { view.addSubview($0) }
        
        // MARK: - Snap kit 제약 잡기
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contenView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        mainTextField.snp.makeConstraints { make in
            make.top.equalTo(contenView).offset(Constants.horizontalMargin)
            make.leading.equalTo(contenView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contenView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        subTextView.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(contenView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contenView.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(400)
        }
        
        imagePickerView.snp.makeConstraints { make in
            make.top.equalTo(subTextView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin)
            //            make.trailing.equalToSuperview().offset(-Constants.horizontalMargin)
            make.size.equalTo(90)
        }
        
        imagePickerStackView.snp.makeConstraints { make in
            make.top.equalTo(subTextView.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin * 7.3)
            make.trailing.equalToSuperview().offset(-Constants.horizontalMargin * 5)
            make.height.equalTo(90)
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
    
}
// MARK: - Actions
extension AddCommunityPageViewController { // ⭐️ Navigation Left,Right BarButtons
    @objc func didTapLeftBarButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
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
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func didTapImagePickerButton() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selection = .ordered
        config.selectionLimit = 3 // 사진 선택 리미티드 3장 까지만
        let imagePickerViewController = PHPickerViewController(configuration: config)
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true)
    }
    
    //    func checkCameraPermission(){ // 카메라 권한 허용 거부 요청
    //        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
    //            if granted {
    //                print("Camera: 권한 허용")
    //            } else {
    //                print("Camera: 권한 거부")
    //            }
    //        })
    //    }
    
        func checkAlbumPermission(){ // 앨범 권한 허용 거부 요청
            PHPhotoLibrary.requestAuthorization( { status in
                switch status{
                case .authorized:
                    print("Album: 권한 허용")
                case .denied:
                    print("Album: 권한 거부")
                case .restricted, .notDetermined:
                    print("Album: 선택하지 않음")
                default:
                    break
                }
            })
        }
    
    //    func showAlertAuth(
    //        _ type: String
    //    ) {
    //        if let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
    //            let alertViewCell = UIAlertController(
    //                title: "설정",
    //                message: "\(appName)이(가) \(type) 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
    //                preferredStyle: .alert
    //            )
    //            let cancelAction = UIAlertAction(
    //                title: "취소",
    //                style: .cancel,
    //                handler: nil
    //            )
    //            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
    //                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    //            }
    //            alertViewCell.addAction(cancelAction)
    //            alertViewCell.addAction(confirmAction)
    //            self.present(alertViewCell, animated: true, completion: nil)
    //        }
    //    }
    
}

private extension AddCommunityPageViewController {
    func attribute() {
        view.backgroundColor = .backgroundCoustomColor
    
        imagePickerView.addSubview(imagePickerButton)   // 이미지 뷰(imagePickerView)에 플러스 버튼을 추가
        imagePickerButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)  // 플러스 버튼의 속성을 설정
        imagePickerButton.tintColor = .buttonSkyBlueColor // 아이콘 색상 설정
        
        imagePickerView.backgroundColor = .white
        imagePickerView.clipsToBounds = true   // 사진 cornerRadius 적용되게
        imagePickerView.layer.cornerRadius = 5
        imagePickerButton.addTarget(
            self,
            action: #selector(didTapImagePickerButton),
            for: .touchUpInside
        )
        imagePickerStackView.addArrangedSubview(imagePickerButton)
        
        numberOfSelectedImageLabel.text = "\(selectedImages.count)"
        numberOfSelectedImageLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        numberOfSelectedImageLabel.textColor = .white
        numberOfSelectedImageLabel.textAlignment = .center
        numberOfSelectedImageLabel.backgroundColor = .mainNavyColor
        numberOfSelectedImageLabel.clipsToBounds = true
        numberOfSelectedImageLabel.layer.cornerRadius = 12.0
    }
    
    func setupNavigationBar() { // NavigationBar 폰트와 컬러 설정
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        if let navigationBar = navigationController?.navigationBar { // UINavigationBar의 titleTextAttributes를 설정
            navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        navigationItem.title = "새 게시물" // UINavigationItem의 title 설정
        
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
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
        
        let rightBarButtontextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        rightBarButtonItem.setTitleTextAttributes(rightBarButtontextAttributes, for: .normal)
        
        leftBarButtonItem.tintColor = .mainNavyColor
        rightBarButtonItem.tintColor = .mainNavyColor
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
                        }
                        DispatchQueue.main.async { // 사진 1-3장 순서대로 나열(0,1,3 순서대로)
                            self.imagePickerView.image = self.selectedImages[0]
                            self.imagePickerView.clipsToBounds = true
                            self.imagePickerView.layer.cornerRadius = 5
                            self.numberOfSelectedImageLabel.text = "\(self.selectedImages.count)"
                            switch self.selectedImages.count {
                            case 2:
                                self.imagePickerStackView.addArrangedSubview(self.secondImageView)
                                self.secondImageView.image = self.selectedImages[1]
                                self.secondImageView.clipsToBounds = true
                                self.secondImageView.layer.cornerRadius = 5
                            case 3:
                                self.imagePickerStackView.addArrangedSubview(self.secondImageView)
                                self.imagePickerStackView.addArrangedSubview(self.thirdImageView)
                                self.secondImageView.image = self.selectedImages[1]
                                self.secondImageView.clipsToBounds = true
                                self.secondImageView.layer.cornerRadius = 5
                                self.thirdImageView.image = self.selectedImages[2]
                                self.thirdImageView.clipsToBounds = true
                                self.thirdImageView.layer.cornerRadius = 5
                            default:
                                break
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

extension AddCommunityPageViewController: UITextViewDelegate { // ⭐️ UITextViewDelegate
    func textViewDidBeginEditing(_ subTextView: UITextView) {
        if subTextView.text == subTextViewPlaceHolder {
            subTextView.text = nil
            subTextView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ subTextView: UITextView) {
        if subTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            subTextView.text = subTextViewPlaceHolder
            subTextView.textColor = .lightGray
        }
    }
}
