import UIKit

import CoreLocation
import iNaviMaps
import MapKit
import SnapKit

class MapPageViewController: UIViewController {
    
    // MARK: Properties
    private let mapView = CustomMapView()
    private let guideView = GuideView()
    
    private let locationManager = CLLocationManager()
    
    private lazy var stationDetailList: [CustomGasStation] = []
    private lazy var locationList: [CustomAnnotation] = []
  
    var myLatitude: CLLocationDegrees?
    var myLongitude: CLLocationDegrees?
    
    private var detailView: UIView!
    
    private lazy var myLocationButton = {
        let button = UIButton()
        if let image = UIImage(named: "currentLocate") {
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(myLocationButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private lazy var zoomInButton = {
        let button = UIButton()
        if let image = UIImage(named: "zoomin") {
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private lazy var zoomOutButton = {
        let button = UIButton()
        if let image = UIImage(named: "zoomout") {
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    // MARK: LifeCycle
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.map.delegate = self
        locationManager.delegate = self
        
        getLocationUsagePermission()
        
        setupMapView()
        addCustomPin()
        addButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.barTintColor = .white
        getLoaction()
    }
    
    // MARK: Method
    func setupMapView() {
        view.addSubview(guideView)
        view.addSubview(myLocationButton)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        
        mapView.map.showsCompass = true
        mapView.map.showsScale = true
        mapView.map.showsUserLocation = true
        mapView.map.setUserTrackingMode(.followWithHeading, animated: true)
        
        guideView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.size.equalTo(100)
        }
        
        myLocationButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        zoomOutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(myLocationButton.snp.top).inset(-10)
        }
        
        zoomInButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(zoomOutButton.snp.top).inset(-10)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            myLatitude = currentLocation.coordinate.latitude
            myLongitude = currentLocation.coordinate.longitude
            fetchCoordinateCurrentLocation(currentLocation)
            if let lat = myLatitude, let lon = myLongitude {
                mapView.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
            }
        }
    }
    
    func fetchCoordinateCurrentLocation(_ location: CLLocation) {
        let lat = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).x)
        let lon = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).y)
        fetchNearByList(x: lat, y: lon)
    }
    
    func fetchNearByList(x: String, y: String) {
        NetworkService.service.fetchNearbyGasStation(x: x, y: y, sort: "1", prodcd: "B027") { [weak self] data in
            if let data = data {
                self?.fetchDetailGasStation(id: data)
            }
        }
    }
    
    func fetchDetailGasStation(id: [String]) {
        NetworkService.service.fetchDetailGasStation(idList: id) { [weak self] data in
            if let data = data {
                self?.stationDetailList = data
            }
            self?.changeAdress(detail: data.map { $0.map { $0.address } } as! [String]) {
                self?.stationDetailList.forEach { item in
                    self?.locationList.append(CustomAnnotation(title: item.name, gasolinePrice: String(item.oilPrice.filter { $0.prodcd == "B027" }.first?.price ?? 0), dieselPrice: String(item.oilPrice.filter { $0.prodcd == "D047" }.first?.price ?? 0), coordinate: CLLocationCoordinate2D(latitude: Double(item.gisYCoor), longitude: Double(item.gisXCoor))))
                    self?.addCustomPin()
                }
            }
        }
    }
    
    func changeAdress(detail: [String], completion: @escaping () -> Void) {
        NetworkService.service.changeAddress(address: detail) { [weak self] data in
            if data?.count != 0 {
                for i in 0 ... (data?.count ?? 0) - 1 {
                    self?.stationDetailList[i].gisXCoor = Float(data?[i].addresses.first?.x ?? "") ?? 0.0
                    self?.stationDetailList[i].gisYCoor = Float(data?[i].addresses.first?.y ?? "") ?? 0.0
                }
                completion()
            }
        }
    }
    
    private func getLoaction() {
        setupLocationManager()
    }
    
    private func removeAnnotation() {
        locationList = []
        mapView.map.annotations.forEach { annotation in
            mapView.map.removeAnnotation(annotation)
        }
    }
    
    private func addCustomPin() {
        mapView.map.addAnnotations(locationList)
        mapView.map.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotationView.self))
    }
    
    private func addButtonActions() {
        mapView.searchButton.addAction(UIAction(handler: { _ in
            self.removeAnnotation()
            self.fetchCoordinateCurrentLocation(CLLocation(latitude: self.myLatitude ?? 0.0, longitude: self.myLongitude ?? 0.0))
        }), for: .touchUpInside)
    }
    
    // MARK: @Objc
    // 현재위치 버튼 입력 시 동작
    @objc func myLocationButtonTapped() {
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.map.setRegion(region, animated: true)
    }
    
    // +버튼 입력 시 동작
    @objc func zoomInButtonTapped() {
        let zoom = 0.5 // 원하는 축척 변경 비율
        let region = mapView.map.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.map.setRegion(newRegion, animated: true)
    }
    
    // -버튼 입력 시 동작
    @objc func zoomOutButtonTapped() {
        let zoom = 2.0 // 원하는 축척 변경 비율
        let region = mapView.map.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.map.setRegion(newRegion, animated: true)
    }
}

extension MapPageViewController: MKMapViewDelegate {
    func setupAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomAnnotationView.self), for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 현재 위치 표시(점)도 일종에 어노테이션이기 때문에, 이 처리를 안하게 되면, 유저 위치 어노테이션도 변경 된다.
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        // 다운캐스팅이 되면 CustomAnnotation를 갖고 CustomAnnotationView를 생성
        if let customAnnotation = annotation as? CustomAnnotation {
            annotationView = setupAnnotationView(for: customAnnotation, on: mapView)
            annotationView?.canShowCallout = false
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        myLatitude = self.mapView.map.centerCoordinate.latitude
        myLongitude = self.mapView.map.centerCoordinate.longitude
    }
    
    // 어노테이션 클릭 시 관련 코드
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var data: CustomGasStation?
        stationDetailList.forEach { station in
            if station.name == mapView.selectedAnnotations.first?.title {
                data = station
            }
        }
        if let data = data {
            let vc = GasStationDetailViewController(data: data)
            present(vc, animated: true)
        }
    }
}

extension MapPageViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getLocationUsagePermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            locationManager.startUpdatingLocation() // 중요!
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
}
