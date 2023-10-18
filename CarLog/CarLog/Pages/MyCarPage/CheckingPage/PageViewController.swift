//
//  PageViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/17.
//

import SnapKit
import UIKit

class PageViewController: UIViewController {
    
    var carouselView: CarouselView?
    var customCarouselView: CustomCarouselView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonActions()
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
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func buttonActions() {
        if let view = carouselView {
            view.firstAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.firstAnswerButton)
            }), for: .touchUpInside)
            view.secondAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.secondAnswerButton)
            }), for: .touchUpInside)
            view.thirdAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.thirdAnswerButton)
            }), for: .touchUpInside)
            view.fourthAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.fourthAnswerButton)
            }), for: .touchUpInside)
            view.fifthAnswerButton.addAction(UIAction(handler: { _ in
                self.checkButtonTapped(sender: view.fifthAnswerButton)
            }), for: .touchUpInside)
        }
    }
    
    func checkButtonTapped(sender: UIButton) {
        if let view = carouselView {
            let temp = [view.firstAnswerButton, view.secondAnswerButton, view.thirdAnswerButton, view.fourthAnswerButton, view.fifthAnswerButton]
            temp.forEach { item in
                item.backgroundColor = .thirdColor
                item.setTitleColor(.black, for: .normal)
            }
            
            switch sender.tag {
            case 1:
                view.firstAnswerButton.backgroundColor = .primaryColor
                view.firstAnswerButton.setTitleColor(.white, for: .normal)
            case 2:
                view.secondAnswerButton.backgroundColor = .primaryColor
                view.secondAnswerButton.setTitleColor(.white, for: .normal)
            case 3:
                view.thirdAnswerButton.backgroundColor = .primaryColor
                view.thirdAnswerButton.setTitleColor(.white, for: .normal)
            case 4:
                view.fourthAnswerButton.backgroundColor = .primaryColor
                view.fourthAnswerButton.setTitleColor(.white, for: .normal)
            case 5:
                view.fifthAnswerButton.backgroundColor = .primaryColor
                view.fifthAnswerButton.setTitleColor(.white, for: .normal)
            default:
                break
            }
        }
    }
}
