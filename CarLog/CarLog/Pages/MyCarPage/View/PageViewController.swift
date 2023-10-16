//
//  PageViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/17.
//

import SnapKit
import UIKit

class PageViewController: UIViewController {
    
    private var carouselView: CarouselView?
    private var customCarouselView: CustomCarouselView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(view: CheckingView, checkingView: Constants.CheckView) {
        super.init(nibName: nil, bundle: nil)
        if checkingView == .normalView {
            carouselView = CarouselView(view: view)
            setupCarouselView()
        } else {
            customCarouselView = CustomCarouselView(view: view)
            setupCustomCarouselView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupCarouselView() {
        view.addSubview(carouselView!)
        
        carouselView!.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCustomCarouselView() {
        view.addSubview(customCarouselView!)
        
        customCarouselView!.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalToSuperview()
        }
    }
    
}
