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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityDetailCollectionViewCell.identifier, for: indexPath) as! CommunityDetailCollectionViewCell
        guard let selectedPost = selectedPost, indexPath.item < selectedPost.image.count else { return cell }
        let imageURL = selectedPost.image[indexPath.item]
        if let url = imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        cell.imageView.image = image
                    } else if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }

        return cell
    }
}

// MARK: - Community 댓글 tableview

extension CommunityDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let comment = commentData.sorted(by: { $0.timeStamp ?? "" > $1.timeStamp ?? "" })[indexPath.row]
        cell.userNameLabel.text = comment.userName
        cell.dateLabel.text = comment.timeStamp
        cell.commentLabel.text = comment.content
        cell.selectionStyle = .none
        updateCommentTableViewHeight()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            // alert창
            self.showAlert(message: "삭제", completion: {
                if let post = self.selectedPost {
                    let postID = post.id ?? ""
                    FirestoreService.firestoreService.loadComments(excludingBlockedPostsFor: Constants.currentUser.userEmail ?? "", postID: postID) { comments in
                        if let comments = comments {
                            if let index = comments.firstIndex(where: { $0.id == self.commentData[indexPath.row].id }) {
                                // 해당 comment를 찾았으므로 삭제
                                self.commentData.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                _ = tableView.rectForRow(at: indexPath).height
                                let commentID = comments[index].id ?? ""
                                FirestoreService.firestoreService.removeComment(commentId: commentID) { err in
                                    if err != nil {
                                        print("err")
                                    }
                                }
                                tableView.reloadData()
                            }
                        }
                    }
                }
            })
        }
        deleteAction.image = UIImage(named: "trash")
        deleteAction.backgroundColor = .backgroundCoustomColor

        let blockAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            self.showAlert(message: "차단", completion: {
                if let post = self.selectedPost {
                    let postID = post.id ?? ""
                    FirestoreService.firestoreService.loadComments(excludingBlockedPostsFor: Constants.currentUser.userEmail ?? "", postID: postID) { comments in
                        if let comments = comments {
                            if let index = comments.firstIndex(where: { $0.id == self.commentData[indexPath.row].id }) {
                                // 해당 comment를 찾았으므로 삭제
                                self.commentData.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                _ = tableView.rectForRow(at: indexPath).height
                                let commentID = comments[index].id ?? ""
                                FirestoreService.firestoreService.blockComment(commentId: commentID, userEmail: Constants.currentUser.userEmail ?? "") { err in
                                    if err != nil {
                                        print("err")
                                    }
                                }
                                tableView.reloadData()
                            }
                        }
                    }
                }
            })
        }
        blockAction.image = UIImage(named: "report") // 시스템 아이콘 사용
        blockAction.backgroundColor = .backgroundCoustomColor

        // 스와이프 액션을 구성합니다.
        let configuration: UISwipeActionsConfiguration

        if let currentUserEmail = Constants.currentUser.userEmail,
           let commentUserEmail = commentData[indexPath.row].userEmail,
           currentUserEmail == commentUserEmail
        {
            configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        } else {
            configuration = UISwipeActionsConfiguration(actions: [blockAction])
        }

        return configuration
    }
}
