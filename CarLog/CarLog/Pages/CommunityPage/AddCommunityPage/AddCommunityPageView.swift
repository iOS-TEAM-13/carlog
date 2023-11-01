//
//  AddCommunityPageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/11/01.
//

import UIKit
import SnapKit

class AddCommunityPageView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

}
