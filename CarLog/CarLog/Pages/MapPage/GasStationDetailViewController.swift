import UIKit

import SnapKit

class GasStationDetailViewController: UIViewController {
    // MARK: Properties
    private let gasStation: CustomGasStation?
    private let stationDetailView = GasStationDetailView()

    // MARK: LifeCycle
    init (data: CustomGasStation) {
        self.gasStation = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true

        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        setupUI()
        updateUI()
    }
    
    // MARK: Method
    private func setupUI() {
        view.addSubview(stationDetailView)
        
        stationDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI() {
        stationDetailView.nameLabel.text = gasStation?.name
        stationDetailView.storeImage.image = gasStation?.cvsYn !=  "Y" ? UIImage(systemName: "x.square") : UIImage(named: "store")
        stationDetailView.carWashImage.image = gasStation?.carWashYn !=  "Y" ? UIImage(systemName: "x.square") : UIImage(named: "carwash")
        let oilPrices = gasStation?.oilPrice ?? []
        if let latestOilPrice = oilPrices.max(by: { $0.tradeDt < $1.tradeDt }) {
            stationDetailView.dateLabel.text = "기준: \(latestOilPrice.tradeDt)"
        } else {
            stationDetailView.dateLabel.text = "날짜 정보 없음"
        }

        stationDetailView.addressLabel.text = gasStation?.address

        stationDetailView.telLabel.text = gasStation?.tel

        if let yellowOilPrice = oilPrices.first(where: { $0.prodcd == "B027" }) {
            stationDetailView.yellowOilPriceLabel.text = "휘발유: \(yellowOilPrice.price.stringToInt())원"
        } else {
            stationDetailView.yellowOilPriceLabel.text = "휘발유 정보 없음"
        }

        if let greenOilPrice = oilPrices.first(where: { $0.prodcd == "D047" }) {
            stationDetailView.greenOilPriceLabel.text = "경유: \(greenOilPrice.price.stringToInt())원"
        } else {
            stationDetailView.greenOilPriceLabel.text = "경유 정보 없음"
        }
    }
}
