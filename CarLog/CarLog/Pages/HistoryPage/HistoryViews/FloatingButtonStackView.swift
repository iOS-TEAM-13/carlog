//
//  FloatingButtonStackView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import UIKit

class FloatingButtonStackView: UIView {
    
    lazy var floatingButtonStackView: UIStackView = {
        let floatingButtonStackView = UIStackView(arrangedSubviews: [fuelingButton, drivingButton, floatingButton])
        floatingButtonStackView.axis = .vertical
        floatingButtonStackView.spacing = Constants.horizontalMargin
        return floatingButtonStackView
    }()
    
    lazy var floatingButton: UIButton = {
        let floatingButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "plus.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        floatingButton.configuration = config
        floatingButton.layer.shadowRadius = 10
        floatingButton.layer.shadowOpacity = 0.3
        
//        floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        
        return floatingButton
    }()
    
    lazy var fuelingButton: UIButton = {
        let fuelingButton = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "fuelpump.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        fuelingButton.configuration = config
        fuelingButton.layer.shadowRadius = 10
        fuelingButton.layer.shadowOpacity = 0.3

//        fuelingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        
        return fuelingButton
    }()
    
    lazy var drivingButton: UIButton = {
        let drivingButton = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "steeringwheel")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        drivingButton.configuration = config
        drivingButton.layer.shadowRadius = 10
        drivingButton.layer.shadowOpacity = 0.3

//        drivingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        
        return drivingButton
    }()
    
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
