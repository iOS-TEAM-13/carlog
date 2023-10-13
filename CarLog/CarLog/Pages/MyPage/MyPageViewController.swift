import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    let mypageView = MyPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(mypageView)
        mypageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
