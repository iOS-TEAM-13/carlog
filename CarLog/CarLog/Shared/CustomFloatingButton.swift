import UIKit

class CustomFloatingButton: UIButton {
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        setupButton(with: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(with image: UIImage?) {
        self.setImage(image, for: .normal)
        self.backgroundColor = .mainNavyColor
        self.layer.cornerRadius = 25
       
    }
}
