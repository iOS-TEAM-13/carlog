import UIKit

import SnapKit

class JoinupPageViewController: UIViewController {
    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    let carModelView = CarModelView()
    let oilModelView = OilModelView()
    let nickNameView = NickNameView()
    let totalDistanceView = TotalDistanceView()
    
    let dummyData = ["휘발유", "경유", "LPG"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        oilModelView.oilCollectionView.register(OilModelCollectionViewCell.self, forCellWithReuseIdentifier: "oilModelCollectionViewCell")
        oilModelView.oilCollectionView.dataSource = self
        oilModelView.oilCollectionView.delegate = self
        setupUI()
        oilModelView.oilCollectionView.reloadData()
        
    }

    func setupUI() {
        view.addSubview(joinupView) //첫번째 화면 뷰
        
        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        joinupView.joinInButton.addTarget(self, action: #selector(joinInButtonTapped), for: .touchUpInside)
        carNumberView.popButton.addTarget(self, action: #selector(carNumberViewPopButtonTapped), for: .touchUpInside)
        carNumberView.nextButton.addTarget(self, action: #selector(carNumberViewPopNextButtonTapped), for: .touchUpInside)
        carModelView.popButton.addTarget(self, action: #selector(carModelViewPopButtonTapped), for: .touchUpInside)
        carModelView.nextButton.addTarget(self, action: #selector(carModelViewNextButtonTapped), for: .touchUpInside)
        oilModelView.popButton.addTarget(self, action: #selector(oilViewPopButtonTapped), for: .touchUpInside)
        oilModelView.nextButton.addTarget(self, action: #selector(oilViewNextButtonTapped), for: .touchUpInside)
        nickNameView.popButton.addTarget(self, action: #selector(nickNameViewPopButtonTapped), for: .touchUpInside)
        nickNameView.nextButton.addTarget(self, action: #selector(nickNameViewNextButtonTapped), for: .touchUpInside)
        totalDistanceView.popButton.addTarget(self, action: #selector(totalDistanceViewPopButtonTapped), for: .touchUpInside)
        totalDistanceView.nextButton.addTarget(self, action: #selector(totalDistanceViewNextButtonTapped), for: .touchUpInside)
    }

    @objc func joinInButtonTapped() {
        view.addSubview(carNumberView)
        joinupView.isHidden = true
        carNumberView.isHidden = false
        carNumberView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    } //회원가입 페이지 버튼

    @objc func carNumberViewPopButtonTapped() {
        joinupView.isHidden = false
        carNumberView.isHidden = true
    }
    @objc func carNumberViewPopNextButtonTapped() {
        view.addSubview(carModelView)
        carNumberView.isHidden = true
        carModelView.isHidden = false
        carModelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func carModelViewPopButtonTapped() {
        carNumberView.isHidden = false
        carModelView.isHidden = true
    }
    @objc func carModelViewNextButtonTapped() {
        view.addSubview(oilModelView)
        carModelView.isHidden = true
        oilModelView.isHidden = false
        oilModelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func oilViewPopButtonTapped() {
        carModelView.isHidden = false
        oilModelView.isHidden = true
    }
    @objc func oilViewNextButtonTapped() {
        view.addSubview(nickNameView)
        oilModelView.isHidden = true
        nickNameView.isHidden = false
        nickNameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func nickNameViewPopButtonTapped() {
        oilModelView.isHidden = false
        nickNameView.isHidden = true
    }
    @objc func nickNameViewNextButtonTapped() {
        view.addSubview(totalDistanceView)
        nickNameView.isHidden = true
        totalDistanceView.isHidden = false
        totalDistanceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func totalDistanceViewPopButtonTapped(){
        nickNameView.isHidden = false
        totalDistanceView.isHidden = true
    }
    @objc func totalDistanceViewNextButtonTapped(){
        self.dismiss(animated: true)
    }
}

extension JoinupPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oilModelView.oilCollectionView.dequeueReusableCell(withReuseIdentifier: "oilModelCollectionViewCell", for: indexPath) as! OilModelCollectionViewCell
        cell.label.text = dummyData[indexPath.item]
        return cell
    }
}

extension JoinupPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
}
