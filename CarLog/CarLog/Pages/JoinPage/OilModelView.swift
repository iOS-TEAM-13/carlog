import UIKit

import SnapKit

class OilModelView: UIView {

    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "이 전", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()

}
