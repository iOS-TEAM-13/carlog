//
//  EditPageViewController.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/30/23.
//

import UIKit

class EditPageViewController: UIViewController {
    var postToEdit: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupUI()
        print("postToEdit:\(postToEdit?.content)")
    }
    
    private func setupUI() {
        if postToEdit != nil {
            
        }
    }
    
}
