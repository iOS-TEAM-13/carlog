//
//  FloatingButtonStackView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class FloatingButtonStackView: UIView {
    
    var navigationController: UINavigationController?
    
    lazy var floatingButtonStackView: UIStackView = {
        let floatingButtonStackView = UIStackView(arrangedSubviews: [fuelingButton, drivingButton, floatingButton])
        floatingButtonStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .center)
        return floatingButtonStackView
    }()
    
    lazy var floatingButton: UIButton = {
        let floatingButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "plus.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        floatingButton.configuration = config
        floatingButton.layer.shadowRadius = 10
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return floatingButton
    }()
    
    lazy var fuelingButton: UIButton = {
        let fuelingButton = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.present(AddFuelingViewController(), animated: true, completion: nil)
            self.navigationController?.modalPresentationStyle = .fullScreen
        }))
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "fuelpump.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        fuelingButton.configuration = config
        fuelingButton.layer.shadowRadius = 10
        fuelingButton.layer.shadowOpacity = 0.3
        fuelingButton.alpha = 0.0
        
        return fuelingButton
    }()
    
    lazy var drivingButton: UIButton = {
        let drivingButton = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.present(AddDrivingViewController(), animated: true, completion: nil)
            self.navigationController?.modalPresentationStyle = .fullScreen
        }))
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "steeringwheel")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        drivingButton.configuration = config
        drivingButton.layer.shadowRadius = 10
        drivingButton.layer.shadowOpacity = 0.3
        drivingButton.alpha = 0.0
        
        return drivingButton
    }()
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
    private var animation: UIViewPropertyAnimator?
    
    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.fuelingButton.layer.transform = CATransform3DIdentity
                self.fuelingButton.alpha = 1.0
            })
            
            drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.drivingButton.layer.transform = CATransform3DIdentity
                self.drivingButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                self.fuelingButton.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                self.drivingButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButton.layer.add(animation, forKey: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(floatingButtonStackView)
        floatingButtonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
