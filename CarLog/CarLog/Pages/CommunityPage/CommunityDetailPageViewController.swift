//
//  CommunityDetailPageViewController.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/1/23.
//

import SnapKit
import UIKit

class CommunityDetailPageViewController: UIViewController, UITextViewDelegate {
    var dummyData: [(userName: String, comment: String)] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundCoustomColor
        tableView.separatorStyle = .none
        tableView.dataSource = self // 데이터 소스 설정
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCoustomColor

        // 네비게이션 바 버튼 이미지 설정
        let dotsImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        let dotsButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(dotsButtonTapped))
        navigationItem.rightBarButtonItem = dotsButton

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(DetailTopTableViewCell.self, forCellReuseIdentifier: "DetailTopTableViewCell")
        tableView.register(DetailMiddleTableViewCell.self, forCellReuseIdentifier: "DetailMiddleTableViewCell")
        tableView.register(DetailBottomTableViewCell.self, forCellReuseIdentifier: "DetailBottomCollectionViewCell")

        addComment(userName: "User6", comment: "세 번째 댓글입니다.")
        addComment(userName: "User7", comment: "네 번째 댓글입니다.")
        addComment(userName: "User8", comment: "네 번째 댓글입니다.")
        addComment(userName: "User9", comment: "네 번째 댓글입니다.")
        addComment(userName: "User10", comment: "네 번째 댓글입니다.")
        tableView.reloadData()
        setupUI()
    }

    // dots 버튼 눌렸을때 동작(드롭다운 메뉴)
    @objc func dotsButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let action1 = UIAlertAction(title: "신고하기", style: .default) { _ in
            print("신고 완료")
            // 옵션 1을 눌렀을 때의 동작을 여기에 추가
        }

        let action2 = UIAlertAction(title: "삭제하기", style: .default) { _ in
            print("삭제 완료")
            // 옵션 2를 눌렀을 때의 동작을 여기에 추가
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    @objc func commentButtonTapped() {
        print("눌렸습니다!")
    }

    private func setupUI() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).offset(Constants.verticalMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
    }
}

extension CommunityDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTopTableViewCell", for: indexPath) as! DetailTopTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMiddleTableViewCell", for: indexPath) as! DetailMiddleTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailBottomCollectionViewCell", for: indexPath) as! DetailBottomTableViewCell
            let (userName, comment) = dummyData[indexPath.row]
            cell.configure(with: userName, comment: comment)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension CommunityDetailPageViewController {
    func addComment(userName: String, comment: String) {
        // 데이터 모델 업데이트
        dummyData.append((userName, comment))

        // 테이블 뷰 업데이트
        let indexPath = IndexPath(row: dummyData.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
