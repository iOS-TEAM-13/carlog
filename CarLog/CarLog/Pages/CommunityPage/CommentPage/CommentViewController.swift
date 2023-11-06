//
//  CommentViewController.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/2/23.
//

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()
    
    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "user (으)로 댓글 달기..."
        textField.backgroundColor = .white
        textField.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("게시", for: .normal)  // "게시"라는 텍스트 설정
            button.setTitleColor(.mainNavyColor, for: .normal)  // 텍스트 색상 설정
            button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)  // 폰트와 크기 설정
            button.backgroundColor = .clear  // 버튼의 배경색 설정
            button.layer.cornerRadius = 5  // 버튼의 모서리 둥글게 설정
        return button
    }()

//    private let commentTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        textView.textAlignment = .left
//        textView.textContainerInset = UIEdgeInsets.zero
//        textView.textContainer.lineFragmentPadding = 0
//        textView.backgroundColor = .clear
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(containerView)
        containerView.addSubview(commentTextField)
        containerView.addSubview(button)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        tableView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.equalToSuperview().offset(16)
            make.rightMargin.equalToSuperview().offset(-16)
            make.bottom.equalTo(containerView.snp.top).offset(12)
        }

        containerView.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(-12)
            make.leftMargin.equalToSuperview().offset(16)
            make.rightMargin.equalToSuperview().offset(-16)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.equalToSuperview().offset(16)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
        
        button.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.left.equalTo(commentTextField.snp.right).offset(16)
            make.rightMargin.equalToSuperview().offset(-16)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
            // 데이터 소스를 기반으로 userNameLabel과 commentLabel의 텍스트 설정 (예: cell.userNameLabel.text = ... 등)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 폰트 크기를 기반으로 한 예상 높이 (여기서는 예를 들기 위해 14로 설정)
        let estimatedFontHeight: CGFloat = 14.0
        let topMargin: CGFloat = 12.0
        let bottomMargin: CGFloat = 12.0
        
        // 높이 계산
        let cellHeight = estimatedFontHeight + topMargin + bottomMargin
        
        return cellHeight
    }

}
