import UIKit

extension UIStackView {
    func customStackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
    }
}
