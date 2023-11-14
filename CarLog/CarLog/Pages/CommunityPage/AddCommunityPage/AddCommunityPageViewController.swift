import UIKit

import FirebaseAuth
import FirebaseStorage
import PhotosUI
import SnapKit

class AddCommunityPageViewController: UIViewController {
    lazy var addCommunityPageView = AddCommunityPageView()
    
    lazy var selectedImages = [UIImage]()
    
    var postToEdit: Post?
    
    // MARK: - Life Cycle
    
    init(post: Post?) {
        super.init(nibName: nil, bundle: nil)
        self.postToEdit = post
        if postToEdit != nil {
            
            addCommunityPageView.mainTextField.text = postToEdit?.title
            addCommunityPageView.subTextView.text = postToEdit?.content
            
            switch postToEdit?.image.count {
            case 1:
                if let first = postToEdit?.image[0] {
                    addCommunityPageView.imagePickerView.load(url: first)
                }
            case 2:
                if let first = postToEdit?.image[0],
                   let second = postToEdit?.image[1] {
                    
                    addCommunityPageView.imagePickerStackView.addArrangedSubview(addCommunityPageView.secondImageView)
                    addCommunityPageView.imagePickerView.load(url: first)
                    addCommunityPageView.secondImageView.load(url: second)
                }
            case 3:
                if let first = postToEdit?.image[0],
                   let second = postToEdit?.image[1],
                   let third = postToEdit?.image[2] {
                   
                    addCommunityPageView.imagePickerStackView.addArrangedSubview(addCommunityPageView.secondImageView)
                    addCommunityPageView.imagePickerStackView.addArrangedSubview(addCommunityPageView.thirdImageView)
                    addCommunityPageView.imagePickerView.load(url: first)
                    addCommunityPageView.secondImageView.load(url: second)
                    addCommunityPageView.thirdImageView.load(url: third)
                }
            case .none:
                break
            case .some(_):
                break
            }
        } else {
            // postToEdit이 nil일떄는 생성 페이지
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        attribute()
        setupUI()
        tabBarController?.tabBar.isHidden = true
    }
    
// MARK: - Setup
    func setupUI() {
        view.addSubview(addCommunityPageView)
        
        addCommunityPageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(addCommunityPageView)
        }
    }
}

// MARK: - Actions
extension AddCommunityPageViewController { // ⭐️ Navigation Left,Right BarButtons
    @objc func didTapLeftBarButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRightBarButton() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh:mm:ss"
        let timeStamp = dateFormatter.string(from: currentDate)
        let dispatchGroup = DispatchGroup()
        var imageURLs: [URL] = []
        
        for i in self.selectedImages {
            dispatchGroup.enter()
            StorageService.storageService.uploadImage(image: i) { url in
                if let url = url {
                    imageURLs.append(url)
                }
                dispatchGroup.leave()
            }
        }
        
        if addCommunityPageView.mainTextField.text != "" {
            dispatchGroup.notify(queue: .main) { [self] in
                let post = Post(id: UUID().uuidString, title: addCommunityPageView.mainTextField.text, content: addCommunityPageView.subTextView.text, image: imageURLs, userEmail: Constants.currentUser.userEmail, userName: Constants.currentUser.nickName, timeStamp: timeStamp, emergency: [:])
                FirestoreService.firestoreService.savePosts(post: post) { error in
                    print("err: \(String(describing: error?.localizedDescription))")
                }
            }
            self.view.isUserInteractionEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showAlert(message: "제목은 필수입니다!", completion: {})
        }
    }
    
    @objc func EditTapRightBarButton() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh:mm:ss"
        let timeStamp = dateFormatter.string(from: currentDate)
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
        if addCommunityPageView.mainTextField.text != "" {
            dispatchGroup.notify(queue: .main) { [self] in
                let post = Post(id: postToEdit?.id, title: addCommunityPageView.mainTextField.text, content: addCommunityPageView.subTextView.text, image: imageURLs, userEmail: Constants.currentUser.userEmail, userName: Constants.currentUser.nickName, timeStamp: timeStamp, emergency: [:])
                FirestoreService.firestoreService.updatePosts(post: post)
                NotificationCenter.default.post(name: Notification.Name("changedPost"), object: post)
            }
            self.view.isUserInteractionEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showAlert(message: "제목은 필수입니다!", completion: {})
        }
    }
    
    @objc func didTapImagePickerButton() {
        checkAlbumPermission()
    }
    
    func checkAlbumPermission() { // 앨범 권한 허용 거부 요청
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Album: 권한 허용")
                var config = PHPickerConfiguration()
                config.filter = .images
                config.selection = .ordered
                config.selectionLimit = 3 // 사진 선택 리미티드 3장 까지만
                DispatchQueue.main.async {
                    let imagePickerViewController = PHPickerViewController(configuration: config)
                    imagePickerViewController.delegate = self
                    self.present(imagePickerViewController, animated: true)
                }
            default:
                DispatchQueue.main.async {
                    self.moveToSettingAlert(reason: "사진 접근 요청 거부됨", discription: "설정에서 권한을 허용해 주세요.")
                }
            }
        }
    }
    
    func moveToSettingAlert(reason: String, discription: String) {
        let alert = UIAlertController(title: reason, message: discription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        cancle.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

private extension AddCommunityPageViewController {
    func attribute() {
        view.backgroundColor = .backgroundCoustomColor
        
        addCommunityPageView.imagePickerButton.addTarget(
            self,
            action: #selector(didTapImagePickerButton),
            for: .touchUpInside
        )
    }
    
    func setupNavigationBar() { // NavigationBar 폰트와 컬러 설정
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        leftBarButtonItem.tintColor = .mainNavyColor
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        if postToEdit == nil {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
                .foregroundColor: UIColor.mainNavyColor
            ]
            
            if let navigationBar = navigationController?.navigationBar { // UINavigationBar의 titleTextAttributes를 설정
                navigationBar.titleTextAttributes = titleTextAttributes
            }
            
            navigationItem.title = "새 게시물" // UINavigationItem의 title 설정
            
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
            
            rightBarButtonItem.tintColor = .mainNavyColor
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
                .foregroundColor: UIColor.mainNavyColor
            ]
            
            if let navigationBar = navigationController?.navigationBar { // UINavigationBar의 titleTextAttributes를 설정
                navigationBar.titleTextAttributes = titleTextAttributes
            }
            
            navigationItem.title = "수정하기" // UINavigationItem의 title 설정
            
            let rightBarButtonItem = UIBarButtonItem(
                title: "완료",
                style: .plain,
                target: self,
                action: #selector(EditTapRightBarButton)
            )
            
            let rightBarButtontextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold),
                .foregroundColor: UIColor.mainNavyColor
            ]
            
            rightBarButtonItem.setTitleTextAttributes(rightBarButtontextAttributes, for: .normal)
            
            rightBarButtonItem.tintColor = .mainNavyColor
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
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
                            DispatchQueue.main.async { // 사진 1-3장 순서대로 나열(0,1,3 순서대로)
                                self.addCommunityPageView.imagePickerView.image = self.selectedImages[0]
                                self.addCommunityPageView.numberOfSelectedImageLabel.text = "\(self.selectedImages.count)"
                                self.addCommunityPageView.imagePickerStackView.removeArrangedSubview(self.addCommunityPageView.secondImageView)
                                self.addCommunityPageView.imagePickerStackView.removeArrangedSubview(self.addCommunityPageView.thirdImageView)
                                self.addCommunityPageView.secondImageView.removeFromSuperview()
                                self.addCommunityPageView.thirdImageView.removeFromSuperview()
                                switch self.selectedImages.count {
                                case 2:
                                    self.addCommunityPageView.imagePickerStackView.addArrangedSubview(self.addCommunityPageView.secondImageView)
                                    self.addCommunityPageView.secondImageView.image = self.selectedImages[1]
                                case 3:
                                    self.addCommunityPageView.imagePickerStackView.addArrangedSubview(self.addCommunityPageView.secondImageView)
                                    self.addCommunityPageView.imagePickerStackView.addArrangedSubview(self.addCommunityPageView.thirdImageView)
                                    self.addCommunityPageView.secondImageView.image = self.selectedImages[1]
                                    self.addCommunityPageView.thirdImageView.image = self.selectedImages[2]
                                default:
                                    break
                                }
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
        if subTextView.text == addCommunityPageView.subTextViewPlaceHolder {
            subTextView.text = nil
            subTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ subTextView: UITextView) {
        if subTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            subTextView.textColor = .lightGray
        }
    }
}
