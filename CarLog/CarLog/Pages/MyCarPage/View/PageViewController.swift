//
//  PageViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/17.
//

import SnapKit
import UIKit

class PageViewController: UIViewController {
    
    private var customView: CarouselView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    init(view: CheckingView) {
        super.init(nibName: nil, bundle: nil)
        customView = CarouselView(view: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        view.addSubview(customView!)
        
        customView!.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
