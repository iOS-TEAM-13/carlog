import UIKit

class GasStationDetailView: UIView {
    
    // 라벨, 이미지 등 ui 요소
    
    private let nameView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let gasStationNameLabel = {
        let label = UILabel()
        
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
        self.addSubview(nameView)
        
        self.backgroundColor = UIColor.firstColor
        
        nameView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(33)
            make.bottom.equalToSuperview().offset(-134)
            make.width.equalTo(340)
            make.height.equalTo(51)
        }
        
    }
    
    
}
