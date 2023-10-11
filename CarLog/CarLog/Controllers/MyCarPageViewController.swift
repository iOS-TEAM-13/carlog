import UIKit

class MyCarPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let uiButton = UIButton()
        uiButton.setTitle("My Button", for: .normal)
        uiButton.backgroundColor = UIColor.secondColor
        
        view.addSubview(uiButton)

        uiButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiButton.widthAnchor.constraint(equalToConstant: 100),
            uiButton.heightAnchor.constraint(equalToConstant: 50)
        ])

//        view.addSubview(timeTitle)
//        timeTitle.translatesAutoresizingMaskIntoConstraints = false
//        timeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        timeTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = UIFont(name: "Jua", size: 16)

        return label
    }()
}
