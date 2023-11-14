import UIKit
import FirebaseAuth
import SnapKit

class CommunityDetailPageViewController: UIViewController {
    private let detailView = CommunityDetailView()
    
    var selectedPost: Post?
    var commentData: [Comment] = []
    lazy var isEmergency = selectedPost?.emergency?[Constants.currentUser.userEmail ?? ""]
    lazy var emergencyCount = selectedPost?.emergency?.filter { $0.value == true }.count {
        didSet {
            if let count = emergencyCount {
                detailView.emergencyCountLabel.text = String(count)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        tabBarController?.tabBar.isHidden = true
        
        // 네비게이션 바 버튼 이미지 설정
        let dotsImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        let dotsButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(dotsButtonTapped))
        navigationItem.rightBarButtonItem = dotsButton
        
        // 컬렉션뷰 셀을 한장씩 넘기게 설정
        detailView.photoCollectionView.isPagingEnabled = true
        detailView.commentTableView.delegate = self
        detailView.commentTableView.dataSource = self
        detailView.photoCollectionView.delegate = self
        detailView.photoCollectionView.dataSource = self
        
        setupUI()
        addTarget()
        setupNavigationBarButton()
        loadPost()
        commentTextViewPlaceholder()
        registerKeyboardNotifications()
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(changedPost(notification:)), name: Notification.Name("changedPost"), object: nil)
        loadComments()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCommentTableViewHeight()
    }
    
    private func setupUI() {
        view.addSubview(detailView.communityDetailPageScrollView)
        view.addSubview(detailView.containerView)
        detailView.communityDetailPageScrollView.addSubview(detailView.communityDetailPageContentView)
        detailView.communityDetailPageContentView.addSubview(detailView.allStackView)
        detailView.communityDetailPageContentView.addSubview(detailView.line)
        detailView.communityDetailPageContentView.addSubview(detailView.commentTableView)
        detailView.containerView.addSubview(detailView.commentTextView)
        detailView.containerView.addSubview(detailView.button)
        
        detailView.communityDetailPageScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(detailView.containerView.snp.top).offset(-8) // 필요한 경우 scrollView와 textView 사이에 간격 추가
        }
        
        detailView.communityDetailPageContentView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
            make.width.equalTo(detailView.communityDetailPageScrollView)
        }
        
        detailView.subTitleStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        detailView.allStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin)
            make.trailing.equalToSuperview().offset(-Constants.horizontalMargin)
        }
        
        detailView.line.snp.makeConstraints { make in
            make.top.equalTo(detailView.allStackView.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin * 2)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin * 2)
            make.height.equalTo(1)
        }
        
        detailView.commentTableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.line.snp.bottom).offset(Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
        // 댓글 레이아웃
        detailView.containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        detailView.commentTextView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.leading.equalToSuperview().offset(Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
        
        detailView.button.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.leading.equalTo(detailView.commentTextView.snp.trailing).offset(Constants.horizontalMargin)
            make.trailing.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
        
        
        if selectedPost?.image.count == 0 {
            detailView.photoCollectionView.isHidden = true
        } else {
            detailView.photoCollectionView.snp.makeConstraints { make in
                make.height.equalTo(345)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
    }
    
    private func addTarget() {
        detailView.emergencyButton.addTarget(self, action: #selector(emergencyButtonTapped), for: .touchUpInside)
        detailView.emergencyButton.setImage(UIImage(named: isEmergency ?? false ? "spaner.fill" : "spaner"), for: .normal)
        detailView.emergencyCountLabel.text = String(emergencyCount ?? 0)
        detailView.button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    
    // 키보드 따라 컨테이너뷰 동적 이동
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        adjustContainerViewForKeyboard(notification: notification, show: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustContainerViewForKeyboard(notification: notification, show: false)
    }
    
    func adjustContainerViewForKeyboard(notification: NSNotification, show: Bool) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        
        let keyboardHeight = show ? keyboardFrame.height : 0
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
        
        // 기존 레이아웃을 유지하되, 키보드 올라올때는 이 레이아웃 사용
        detailView.containerView.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(-keyboardHeight)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("completedCheckingView"), object: nil)
    }
    
    // dots 버튼 눌렸을때 동작(드롭다운 메뉴)
    
    @objc func dotsButtonTapped() {
        guard let post = selectedPost else { return }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 현재 사용자가 포스트의 작성자가 일치하는지 확인
        if post.userEmail == Constants.currentUser.userEmail {
            // 네이게션 edit
            let editAction = UIAlertAction(title: "수정하기", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                self.navigateToEditPage(post: post)
            }
            let action2 = UIAlertAction(title: "삭제하기", style: .default) { _ in
                // 삭제 기능 로직
                self.showAlert(checkText: "게시글을 정말로 삭제하시겠습니까?") {
                    FirestoreService.firestoreService.removePost(postID: self.selectedPost?.id ?? "") { err in
                        if err != nil {
                            print("에러")
                        }
                    }
                    print("삭제 완료")
                    self.navigationController?.popViewController(animated: true)
                    self.tabBarController?.tabBar.isHidden = false
                }
            }
            editAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            action2.setValue(UIColor.systemRed, forKey: "titleTextColor")
            actionSheet.addAction(editAction)
            actionSheet.addAction(action2)
        } else {
            let action3 = UIAlertAction(title: "\(String(describing: post.userName ?? ""))님 차단하기", style: .default) { _ in
                self.showAlert(checkText: "\(post.userName ?? "")님을 차단하시겠습니까?") {
                    FirestoreService.firestoreService.blockUser(userName: self.selectedPost?.userName ?? "", userEmail: Constants.currentUser.userEmail ?? "") { error in
                        if let error = error {
                            print("차단 오류: \(error.localizedDescription)")
                        } else {
                            print("차단 완료")
                            self.navigationController?.popViewController(animated: true)
                            self.tabBarController?.tabBar.isHidden = false
                        }
                    }
                }
            }
            let action4 = UIAlertAction(title: "해당 게시글 차단하기", style: .default) { [weak self] _ in
                guard let self = self, let postID = self.selectedPost?.id, let userEmail = Constants.currentUser.userEmail else { return }
                self.showAlert(checkText: "해당 게시글을 차단하시겠습니까?") {
                    FirestoreService.firestoreService.blockPost(postID: postID, userEmail: userEmail) { error in
                        if let error = error {
                            print("차단 오류: \(error.localizedDescription)")
                        } else {
                            print("차단 완료")
                            self.navigationController?.popViewController(animated: true)
                            self.tabBarController?.tabBar.isHidden = false
                        }
                    }
                }
            }
            action3.setValue(UIColor.systemRed, forKey: "titleTextColor")
            action4.setValue(UIColor.systemRed, forKey: "titleTextColor")
            actionSheet.addAction(action3)
            actionSheet.addAction(action4)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // 좋아요 버튼 눌렀을 떄 동작 구현
    @objc func emergencyButtonTapped() {
        isEmergency = !(isEmergency ?? false)
        selectedPost?.emergency?.updateValue(isEmergency ?? false, forKey: Constants.currentUser.userEmail ?? "")
        setEmergencyButton()
    }
    
    private func setEmergencyButton() {
        if let post = selectedPost {
            FirestoreService.firestoreService.updatePosts(postID: post.id ?? "", emergency: post.emergency ?? [:])
        }
        if isEmergency ?? false {
            detailView.emergencyButton.setImage(UIImage(named: "spaner.fill"), for: .normal)
            emergencyCount = (emergencyCount ?? 0) + 1
        } else {
            detailView.emergencyButton.setImage(UIImage(named: "spaner"), for: .normal)
            emergencyCount = (emergencyCount ?? 0) - 1
        }
    }
    
    // MARK: - 댓글 기능
    
    @objc func commentButtonTapped() {
        if let commentText = detailView.commentTextView.text, !commentText.isEmpty {
            addComment(comment: commentText)
            detailView.commentTableView.reloadData()
            detailView.commentTextView.text = ""
        }
    }
    
    private func commentTextViewPlaceholder() {
        detailView.commentTextView.delegate = self
        detailView.commentTextView.text = "댓글쓰기"
        detailView.commentTextView.textColor = .lightGray
    }
    
    func updateCommentTableViewHeight() {
        let contentSize = detailView.commentTableView.contentSize
        detailView.commentTableView.snp.updateConstraints { make in
            make.height.equalTo(contentSize.height + 50)
        }
    }
    
    func updateDeleteCommentTableViewHeight(cellHeight: CGFloat) {
        let currentHeight = detailView.commentTableView.bounds.size.height
        let newHeight = currentHeight - cellHeight
        let minHeight: CGFloat = 0
        let finalHeight = max(minHeight, newHeight)
        detailView.commentTableView.snp.updateConstraints { make in
            make.height.equalTo(finalHeight)
        }
    }
    
    func addComment(comment: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let timeStamp = dateFormatter.string(from: Date())
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }
        
        let newComment = Comment(id: UUID().uuidString, postId: selectedPost?.id ?? "", content: comment, userName: Constants.currentUser.nickName, userEmail: userEmail, timeStamp: timeStamp)
        FirestoreService.firestoreService.saveComment(comment: newComment) { error in
            if let error = error {
                print("Error saving comment: \(error.localizedDescription)")
            } else {
                print("save success")
                self.commentData.append(newComment)
                self.commentData.sort { $0.timeStamp ?? "" > $1.timeStamp ?? "" }
                DispatchQueue.main.async {
                    self.detailView.commentTableView.reloadData()
                    self.updateCommentTableViewHeight()
                }
            }
        }
    }
    
    // 키보드
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

extension CommunityDetailPageViewController {
    @objc func changedPost(notification: Notification) {
        if let updatedPost = notification.object as? Post {
            selectedPost = updatedPost
            loadPost()
            detailView.photoCollectionView.reloadData()
        }
    }
    
    private func setupNavigationBarButton() {
        navigationController?.navigationBar.tintColor = .mainNavyColor
        if let backImage = UIImage(systemName: "chevron.left") {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapLeftBarButton))
        }
    }
    
    @objc func didTapLeftBarButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    private func loadPost() {
        if let post = selectedPost {
            detailView.userNameLabel.setTitle(post.userName, for: .normal)
            detailView.titleLabel.text = post.title
            detailView.dateLabel.text = post.timeStamp
            detailView.mainText.text = post.content
        }
    }
    
    private func loadComments() {
        if let post = selectedPost {
            FirestoreService.firestoreService.loadComments(excludingBlockedPostsFor: Constants.currentUser.userEmail ?? "", postID: post.id ?? "") { comments in
                if let comments = comments {
                    for comment in comments {
                        self.commentData.append(comment)
                    }
                    self.detailView.commentTableView.reloadData()
                }
            }
        }
    }
    
    private func navigateToEditPage(post: Post) {
        let vc = AddCommunityPageViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CommunityDetailPageViewController {
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
