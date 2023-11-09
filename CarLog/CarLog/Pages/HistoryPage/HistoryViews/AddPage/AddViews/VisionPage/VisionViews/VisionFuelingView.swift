//
//  VisionFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit

class VisionFuelingView: UIView {
    
    lazy var addvisionStackView: UIStackView = {
        let visionStackView = UIStackView(arrangedSubviews: [addVisionLabel, addVisionButton, fuelingImageView])
        visionStackView.customStackView(spacing: 30, axis: .vertical, alignment: .center)
        return visionStackView
    }()
    
    lazy var addVisionLabel: UILabel = {
        let addVisionLabel = UILabel()
        addVisionLabel.customLabel(text: "영수증을 선택해주세요.", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return addVisionLabel
    }()
    
    lazy var addVisionButton: UIButton = {
        let addVisionButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        addVisionButton.configuration = config
        return addVisionButton
    }()
    
    lazy var fuelingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addVisionFueling UI 설정
    private func setupUI() {
        addSubview(addvisionStackView)
        
        addvisionStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        addVisionButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        fuelingImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
    
    //
    func setVisionImage(image: UIImage) {
        let resizedImage = image.resize(to: CGSize(width: 150, height: 150))
        addVisionButton.setImage(resizedImage, for: .normal)
        addVisionButton.contentMode = .scaleAspectFit
    }
}

//extension UIImage {
//    func resize(to newSize: CGSize) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        return UIGraphicsGetImageFromCurrentImageContext() ?? self
//    }
//}

