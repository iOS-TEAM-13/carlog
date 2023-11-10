import UIKit

import FirebaseAuth
import SnapKit

class CommunityDetailPageViewController: UIViewController {
    var selectedPost: Post?
    var commentData: [Comment] = []
    lazy var isEmergency = selectedPost?.emergency?[Constants.currentUser.userEmail ?? ""]
    lazy var emergencyCount = selectedPost?.emergency?.filter { $0.value == true }.count {
        didSet {
            if let count = emergencyCount {
                emergencyCountLabel.text = String(count)
            }
        }
    }
    
    lazy var commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        return tableView
    }()
    
    lazy var communityDetailPageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var communityDetailPageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "달려라 달려라~"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var userNameLabel: UIButton = {
        let button = UIButton()
        button.setTitle("왕바우", for: .normal) // "게시"라는 텍스트 설정
        button.setTitleColor(.black, for: .normal) // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium) // 폰트와 크기 설정
        button.backgroundColor = .clear // 버튼의 배경색 설정
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    lazy var divideView = UIView()
    
    lazy var subTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, divideView, dateLabel])
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .center)
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 345)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityDetailCell")
        return collectionView
    }()
    
    lazy var emergencyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(emergencyButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: isEmergency ?? false ? "spaner.fill" : "spaner"), for: .normal)
        return button
    }()
    
    lazy var emergencyCountLabel: UILabel = {
        let label = UILabel()
        label.text = String(emergencyCount ?? 0)
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emergencyButton, emergencyCountLabel])
        stackView.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return stackView
    }()
    
    // textview 로 수정
    lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "카 \n로 \n그 \n언 \n더 \n독"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var commentUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "user1"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleStackView, photoCollectionView, likeStackView, mainText, line])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .leading)
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글..."
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 댓글
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCoustomColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        return textView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("게시", for: .normal) // "게시"라는 텍스트 설정
        button.setTitleColor(.mainNavyColor, for: .normal) // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold) // 폰트와 크기 설정
        button.backgroundColor = .clear // 버튼의 배경색 설정
        button.layer.cornerRadius = 5 // 버튼의 모서리 둥글게 설정
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupUI() {
        view.addSubview(communityDetailPageScrollView)
        view.addSubview(containerView)
        communityDetailPageScrollView.addSubview(communityDetailPageContentView)
        communityDetailPageScrollView.addSubview(allStackView)
        communityDetailPageContentView.addSubview(line)
        communityDetailPageContentView.addSubview(commentTableView)
        containerView.addSubview(commentTextView)
        containerView.addSubview(button)
        
        if selectedPost?.image.count == 0 {
            photoCollectionView.isHidden = true
        } else {
            photoCollectionView.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 360, height: 345))
            }
        }
        
        commentTableView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        communityDetailPageScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top).offset(-8) // 필요한 경우 scrollView와 textView 사이에 간격 추가
        }
        
        emergencyButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        communityDetailPageContentView.snp.makeConstraints { make in
            make.edges.equalTo(communityDetailPageScrollView)
            make.width.equalTo(communityDetailPageScrollView)
        }
        
        allStackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(allStackView.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin * 2)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin * 2)
            make.height.equalTo(1)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
        // 댓글 레이아웃
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
        
        button.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.left.equalTo(commentTextView.snp.right).offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
        }
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
        containerView.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(-keyboardHeight)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
                let editPageViewController = EditPageViewController()
                
                // 선택한 포스트를 가져와서 EditPageViewController에 설정
                let editPost = selectedPost
                editPageViewController.postToEdit = editPost
                self.navigateToEditPage(post: post)
                // 수정 기능 로직
                //                print("수정 완료")
            }
            let action2 = UIAlertAction(title: "삭제하기", style: .default) { _ in
                // 삭제 기능 로직
                
                FirestoreService.firestoreService.removePost(postID: self.selectedPost?.id ?? "") { err in
                    if err != nil {
                        print("에러")
                    }
                }
                print("삭제 완료")
            }
            editAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            action2.setValue(UIColor.systemRed, forKey: "titleTextColor")
            actionSheet.addAction(editAction)
            actionSheet.addAction(action2)
        } else {
            let action3 = UIAlertAction(title: "신고하기", style: .default) { _ in
                // 신고 기능 로직
                print("신고 완료")
            }
            let action4 = UIAlertAction(title: "차단하기", style: .default) { _ in
                // 차단 기능 로직
                print("차단 완료")
            }
            //            let action5 = UIAlertAction(title: "\(Auth.().)", style: <#T##UIAlertAction.Style#>)
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
            emergencyButton.setImage(UIImage(named: "spaner.fill"), for: .normal)
            emergencyCount = (emergencyCount ?? 0) + 1
        } else {
            emergencyButton.setImage(UIImage(named: "spaner"), for: .normal)
            emergencyCount = (emergencyCount ?? 0) - 1
        }
    }
    
    // MARK: - 댓글 기능
    
    @objc func commentButtonTapped() {
        print("눌렸습니다!")
        if let commentText = commentTextView.text, !commentText.isEmpty {
            addComment(comment: commentText)
            commentTableView.reloadData()
            updateCommentTableViewHeight() // 댓글이 추가된 후에 높이를 업데이트합니다.
            commentTextView.text = ""
        }
    }
    
    private func commentTextViewPlaceholder() {
        commentTextView.delegate = self
        commentTextView.text = "댓글쓰기"
        commentTextView.textColor = .lightGray
    }
    
    func updateCommentTableViewHeight() {
        let contentSize = commentTableView.contentSize
        commentTableView.snp.updateConstraints { make in
            make.height.equalTo(contentSize.height)
        }
    }
    
    func updateDeleteCommentTableViewHeight(cellHeight: CGFloat) {
        let currentHeight = commentTableView.bounds.size.height
        let newHeight = currentHeight - cellHeight
        let minHeight: CGFloat = 0
        let finalHeight = max(minHeight, newHeight)
        commentTableView.snp.updateConstraints { make in
            make.height.equalTo(finalHeight)
        }
    }
    
    func addComment(comment: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let timeStamp = dateFormatter.string(from: Date())
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }
        
        let newComment = Comment(id: UUID().uuidString, postId: selectedPost?.id ?? "", content: comment, userName: Constants.currentUser.nickName, userEmail: userEmail, timeStamp: timeStamp, blockComment: [:])
        FirestoreService.firestoreService.saveComment(comment: newComment) { error in
            if let error = error {
                print("Error saving comment: \(error.localizedDescription)")
            } else {
                print("save success")
                self.commentData.append(newComment)
                self.commentData.sort { $0.timeStamp ?? "" > $1.timeStamp ?? "" }
                DispatchQueue.main.async {
                    self.commentTableView.reloadData()
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
        photoCollectionView.isPagingEnabled = true
        
        setupUI()
        setupNavigationBarButton()
        loadPost()
        commentTextViewPlaceholder()
        registerKeyboardNotifications()
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("==== \(commentTableView.frame.height)")
        loadComments()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCommentTableViewHeight()
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
            userNameLabel.setTitle(post.userName, for: .normal)
            titleLabel.text = post.title
            dateLabel.text = post.timeStamp
            mainText.text = post.content
        }
    }
    
    private func loadComments() {
        if let post = selectedPost {
            FirestoreService.firestoreService.loadComments(postID: post.id ?? "") { comments in
                if let comments = comments {
                    //print("comments = \(comments)")
                    
                    for comment in comments {
                        self.commentData.append(comment)
                        
                    }
                    self.commentTableView.reloadData()
                }
            }
        }
    }
    
    private func navigateToEditPage(post: Post) {
        let editPageViewController = EditPageViewController()
        editPageViewController.postToEdit = post // EditPageViewController에 수정할 포스트 정보 전달
        navigationController?.pushViewController(editPageViewController, animated: true)
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
