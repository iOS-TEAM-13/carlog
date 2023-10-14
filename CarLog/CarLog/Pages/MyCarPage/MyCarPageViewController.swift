import UIKit
import SnapKit
import SwiftUI

class MyCarPageViewController: UIViewController {
    
    //MARK: Properties
    private let myCarTableView = UITableView()
    
    private let dummy = CarInfo(engineOil: "엔진 오일", missionOil: "미션 오일", brakeOil: "브레이크 오일", brakePad: "브레이크 패드", tire: "타이어", tireRotation: "로테이션", fuelFilter: "연료 필터", wiper: "와이퍼", airconFilter: "에어컨 필터", insurance: "보험")
    private let menuIcon = [UIImage(named: "engineOil"), UIImage(named: "missionOil"), UIImage(named: "brakeOil"), UIImage(named: "brakePad"), UIImage(named: "tire"), UIImage(named: "tireRotation"), UIImage(named: "fuelFilter"), UIImage(named: "wiperBlade"), UIImage(named: "airconFilter"), UIImage(named: "insurance")]
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        
        registerTableview()
        setupUI()
    }
    
    //MARK: Method
    private func registerTableview() {
        myCarTableView.delegate = self
        myCarTableView.dataSource = self
        myCarTableView.register(MyCarTableViewCell.self, forCellReuseIdentifier: MyCarTableViewCell.identifier)
    }
    
    private func setupUI() {
        view.addSubview(myCarTableView)
        
        myCarTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.verticalMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
    }
}

extension MyCarPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCarTableViewCell.identifier, for: indexPath) as? MyCarTableViewCell else { return UITableViewCell() }
        let mirror = Mirror(reflecting: dummy)
        let temp = mirror.children.compactMap{$0.value as? String}[indexPath.row]
        if let icon = menuIcon[indexPath.row] {
            cell.bind(text: temp, period: "기간1", icon: icon)
    //
        }
        cell.layer.cornerRadius = 20
//        cell.backgroundColor = .thirdColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyCarCheckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
    }
}

// SwiftUI를 활용한 미리보기
struct MyCarPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyCarPageVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct MyCarPageVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let myCarPageVC = MyCarPageViewController()
        return UINavigationController(rootViewController: myCarPageVC)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    typealias UIViewControllerType = UIViewController
}
