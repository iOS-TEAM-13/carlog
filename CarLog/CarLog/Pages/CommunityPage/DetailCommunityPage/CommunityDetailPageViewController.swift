import UIKit

import FirebaseAuth
import SnapKit

class CommunityDetailPageViewController: UIViewController {
    var selectedPost: Post?
    let currentDate = Date()
    var commentData: [Comment] = []
    // 좋아요 버튼 설정
    private var isLiked = false {
        didSet {
            updateLikeButton()
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
    
    lazy var subTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, UIView(), dateLabel])
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
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "spaner"), for: .normal)
        button.setImage(UIImage(named: "spaner.fill"), for: .selected)
        button.tintColor = .red
        button.addTarget(CommunityDetailPageViewController.self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.text = "264"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, likeCount])
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
        
        likeButton.snp.makeConstraints { make in
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
            make.bottomMargin.equalToSuperview()
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
    //키보드 따라 컨테이너뷰 동적 이동
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
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
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
        guard let user = Auth.auth().currentUser, let post = selectedPost else { return }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 현재 사용자가 포스트의 작성자가 일치하는지 확인
        if post.userEmail == user.email {
            let action1 = UIAlertAction(title: "수정하기", style: .default) { _ in
                //수정 기능 로직
                print("수정 완료")
            }
            let action2 = UIAlertAction(title: "삭제하기", style: .default) { _ in
                //삭제 기능 로직
                print("삭제 완료")
            }
            action1.setValue(UIColor.backgroundCoustomColor, forKey: "titleTextColor")
            action2.setValue(UIColor.backgroundCoustomColor, forKey: "titleTextColor")
            actionSheet.addAction(action1)
            actionSheet.addAction(action2)
        } else {
            let action3 = UIAlertAction(title: "신고하기", style: .default) { _ in
                // 신고 기능 로직
                print("신고 완료")
            }
            let action4 = UIAlertAction(title: "차단하기", style: .default) { _ in
                //차단 기능 로직
                print("차단 완료")
            }
//            let action5 = UIAlertAction(title: "\(Auth.().)", style: <#T##UIAlertAction.Style#>)
            action3.setValue(UIColor.red, forKey: "titleTextColor")
            action4.setValue(UIColor.red, forKey: "titleTextColor")
            actionSheet.addAction(action3)
            actionSheet.addAction(action4)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // 좋아요 버튼 눌렀을 떄 동작 구현
    @objc func likeButtonTapped() {
        isLiked.toggle()
    }

    private func updateLikeButton() {
        likeButton.isSelected = isLiked
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
            make.height.equalTo(contentSize.height * 1.5 + 20)
        }
    }
    
    func addComment(comment: String) {
        let timeStamp = DateFormatter.localizedString(from: currentDate, dateStyle: .short, timeStyle: .short)
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }

        FirestoreService.firestoreService.fetchNickName(userEmail: userEmail) { [weak self] nickName in
            guard let self = self, let postID = self.selectedPost?.id else { return }
            
            let userNickName = nickName
            let newComment = Comment(id: UUID().uuidString, content: comment, userName: userNickName, userEmail: userEmail, timeStamp: timeStamp)
            
            FirestoreService.firestoreService.saveComment(postID: postID, comment: newComment) { error in
                if let error = error {
                    print("Error saving comment: \(error.localizedDescription)")
                } else {
                    print("Comment saved successfully")
                    self.commentData.append(newComment)
                    self.commentData.sort { $0.timeStamp ?? "" > $1.timeStamp ?? "" }
                    
                    DispatchQueue.main.async {
                        self.commentTableView.reloadData()
                        self.updateCommentTableViewHeight()
                    }
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
        loadComments()
        commentTextViewPlaceholder()
        registerKeyboardNotifications()
        setupHideKeyboardOnTap()
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
            FirestoreService.firestoreService.fetchNickName(userEmail: post.userEmail ?? "") { nickName in
                self.userNameLabel.setTitle(nickName, for: .normal)
                self.titleLabel.text = post.title
                self.dateLabel.text = post.timeStamp
                self.mainText.text = post.content
            }
        }
    }
    
    private func loadComments() {
        if let post = selectedPost {
            FirestoreService.firestoreService.getComments(forPostID: post.id!) { comments, error in
                if let error = error {
                    print("Error loading comments: \(error.localizedDescription)")
                } else if let comments = comments {
                    print("Loaded comments: \(comments)")
                    for comment in comments {
                        self.commentData.append(comment)
                        self.commentTableView.reloadData()
                    }
                }
            }
        }
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
