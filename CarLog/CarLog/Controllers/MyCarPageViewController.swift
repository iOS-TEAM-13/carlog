import UIKit

class MyCarPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        //MARK - 예시
        view.addSubview(timeTitle)
        timeTitle.translatesAutoresizingMaskIntoConstraints = false
        timeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = UIFont(name: "Jua", size: 16)

        return label
    }()
}
