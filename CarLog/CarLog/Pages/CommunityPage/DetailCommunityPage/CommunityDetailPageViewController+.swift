//
//  CommunityDetailPageViewController+.swift
//  CarLog
//
//  Created by 김은경 on 11/7/23.
//

import UIKit

import FirebaseAuth

extension CommunityDetailPageViewController {}

extension CommunityDetailPageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ""
            textView.textColor = UIColor.lightGray
        }
    }
}

// MARK: - Community 사진

extension CommunityDetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let selectedPost = selectedPost else {
            return 0
        }

        return selectedPost.image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityDetailCell", for: indexPath) as! CommunityDetailCollectionViewCell

        guard let selectedPost = selectedPost, indexPath.item < selectedPost.image.count else {
            cell.imageView.image = UIImage(named: "placeholderImage") // 대체 이미지 설정 예시
            return cell
        }

        let imageURL = selectedPost.image[indexPath.item]
        if let url = imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                } else if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            // URL이 nil인 경우에 대한 처리
            cell.imageView.image = UIImage(named: "placeholderImage") // 대체 이미지 설정 예시
        }

        return cell
    }
}

// MARK: - Community 댓글 tableview

extension CommunityDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("commentDatacount: \(commentData.count)")
        return commentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let comment = commentData[indexPath.row]

        print("comment: \(comment)")
        cell.userNameLabel.text = comment.userName
        cell.commentLabel.text = comment.content

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // 또는 적절한 높이 값
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // '삭제' 액션
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            if let post = self.selectedPost {
                let userIDToMatch = Auth.auth().currentUser?.email
                let commentsRef = FirestoreService.firestoreService.db.collection("posts").document(post.id ?? "").collection("comments")

                commentsRef.whereField("userEmail", isEqualTo: userIDToMatch ?? "").getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error getting documents: \(error.localizedDescription)")
                    } else if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                        for document in querySnapshot.documents {
                            let commentID = document.documentID
                            print("Deleting comment with id: \(commentID)")
                            document.reference.delete { error in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                } else {
                                    print("댓글이 성공적으로 삭제됨")
                                    self.commentData.remove(at: indexPath.row)
                                    tableView.deleteRows(at: [indexPath], with: .fade)
                                }
                            }
                            break
                        }
                    } else {
                        print("문서가 없음")
                    }
                }
            }
        }
        deleteAction.image = UIImage(named: "trash") // 시스템 아이콘 사용
        deleteAction.backgroundColor = .backgroundCoustomColor
        // '신고' 액션
        let reportAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            // '신고'를 눌렀을 때 실행할 코드
            completionHandler(true)
        }
        reportAction.image = UIImage(named: "report") // 시스템 아이콘 사용
        reportAction.backgroundColor = .backgroundCoustomColor
        // 스와이프 액션을 구성합니다.
        let configuration = UISwipeActionsConfiguration(actions: [reportAction, deleteAction])
        return configuration
    }
}
