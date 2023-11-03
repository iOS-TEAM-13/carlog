import UIKit

import CoreLocation
import iNaviMaps
import MapKit
import SnapKit

class MapPageViewController: UIViewController, CLLocationManagerDelegate {
    let mapView = CustomMapView()
    var stationList: [GasStationSummary] = []
    var stationDetailList: [CustomGasStation] = []
    var newAddress: [(String, String)]?
    
    var gasStationDetailView: GasStationDetailView?
    
    private lazy var locationList: [CustomAnnotation] = []
    
    let locationManager = CLLocationManager()
    let test = [CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.748832, longitude: 127.081867))]
  
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
    
    private lazy var mapDetailView: GasStationDetailView = {
        let view = GasStationDetailView()
        view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 250)
        view.clipsToBounds = true
        return view
    }()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
        mapView.map.delegate = self
        locationManager.delegate = self
        
        mapView.map.showsUserLocation = true
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideDetailView(_:)))
//        mapView.addGestureRecognizer(tapGesture)
//        tapGesture.delegate = self
//        gasStationDetailView = GasStationDetailView()
        
//        setupMapView()
        
        addCustomPin()
        getLocationUsagePermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLoaction()
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        view.addSubview(myLocationButton)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        view.addSubview(mapDetailView)
        
        // 나침반 표시 여부
        mapView.map.showsCompass = true
        // 축척 정보 표시 여부
        mapView.map.showsScale = true
        // 위치 사용 시 사용자의 연재 위치 표시
        mapView.map.showsUserLocation = true
        // 사용자 위치를 표시하고 사용자가 움직일 때마다 지도도 함께 움직여 사용자의 현재 위치를 중심으로 유지
        // mapView.setUserTrackingMode(.follow, animated: true)
        // 사용자의 방향에 따라 회전(나침반 기능과 함께 사용)
        mapView.map.setUserTrackingMode(.followWithHeading, animated: true)
        
        mapView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(10)
            make.bottomMargin.equalToSuperview().offset(-40)
        }
        
        zoomOutButton.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(10)
            make.bottomMargin.equalToSuperview().offset(-94)
        }
        
        zoomInButton.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(10)
            make.bottomMargin.equalToSuperview().offset(-148)
        }
    }
    
    
    
//    // 디테일 뷰 상단만 코너래디우스 주기
//    func applyTopCornersRadius(to view: UIView, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
//
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//
//        view.layer.mask = mask
//    }
    
//    func updateAnnotationToCustomView(_ annotationView: MKAnnotationView, annotation: MKAnnotation) {
//        annotationView.image = nil
//        let view = UIView()
//        view.backgroundColor = .white
//        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        view.layer.cornerRadius = 8
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 3
//        view.layer.shadowOpacity = 0.3
//
//        let label = UILabel(frame: view.bounds)
//        label.text = "휘발유:2000원 \n경유: 1400원"
//        label.font = UIFont(name: "Jua", size: 10)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        view.addSubview(label)
//
//        annotationView.addSubview(view)
//        annotationView.frame = view.frame
//    }
    
    func getLocationUsagePermission() {
        // location4
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // location5
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
    
//    func hideDetailView() {
//        UIView.animate(withDuration: 0.3) {
//            self.mapDetailView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 200)
//        }
//    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            fetchCoordinateCurrentLocation(currentLocation)
            myLatitude = currentLocation.coordinate.latitude
            myLongitude = currentLocation.coordinate.longitude
            if let lat = myLatitude, let lon = myLongitude {
                mapView.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
            }
        }
    }
    
    func fetchCoordinateCurrentLocation(_ location: CLLocation) {
        let lat = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).x)
        let lon = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).y)
        self.fetchNearByList(x: lat, y: lon)
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
            self?.changeAdress(detail: data.map { $0.map{ $0.address } } as! [String]) {
                self?.stationDetailList.forEach{ item in
                    self?.locationList.append(CustomAnnotation(title: item.name,gasolinePrice: String(item.oilPrice.filter{ $0.prodcd == "B027" }.first?.price ?? 0), dieselPrice: String(item.oilPrice.filter{ $0.prodcd == "D047" }.first?.price ?? 0), coordinate: CLLocationCoordinate2D(latitude: Double(item.gisYCoor), longitude: Double(item.gisXCoor))))
                    self?.addCustomPin()
                }
            }
        }
    }
    
    func changeAdress(detail: [String], completion: @escaping () -> Void) {
        NetworkService.service.changeAddress(address: detail) { [weak self] data in
            if data?.count != 0 {
                for i in 0...(data?.count ?? 0) - 1 {
                    self?.stationDetailList[i].gisXCoor = Float(data?[i].addresses.first?.x ?? "") ?? 0.0
                    self?.stationDetailList[i].gisYCoor = Float(data?[i].addresses.first?.y ?? "") ?? 0.0
                }
                completion()
            }
        }
    }
    
    private func getLoaction() {
//        removeAnnotation()
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
    
//    @objc func handleTapOutsideDetailView(_ gesture: UITapGestureRecognizer) {
//        let location = gesture.location(in: view)
//        if !mapDetailView.frame.contains(location) {
//            // mapDetailView 바깥 영역을 탭했을 경우
//            hideDetailView()
//        }
//    }
    
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
    
    // 어노테이션 클릭 시 관련 코드
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("어노테이션이 클릭되었습니다.")
//        if let _ = view.annotation as? MKPointAnnotation {
//            // 어노테이션을 클릭했을 때 detailView 나오게 함
//            UIView.animate(withDuration: 0.1) {
//                self.mapDetailView.frame = CGRect(x: 0, y: self.view.bounds.height - 250 - self.view.safeAreaInsets.bottom, width: self.view.bounds.width, height: 250) // 높이와 y 위치를 200으로 변경
//                mapView.deselectAnnotation(view.annotation, animated: false)
//            }
//            applyTopCornersRadius(to: mapDetailView, radius: 15)
//        }
    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        if mapView.region.span.latitudeDelta < 0.01 {
//            for annotation in mapView.annotations {
//                if let annotationView = mapView.view(for: annotation), !(annotation is MKUserLocation) {
//                    updateAnnotationToCustomView(annotationView, annotation: annotation)
//                }
//            }
//        } else {
//            for annotation in mapView.annotations {
//                if let annotationView = mapView.view(for: annotation), !(annotation is MKUserLocation) {
//                    updateAnnotationToPin(annotationView)
//                }
//            }
//        }
//    }
}

extension MapPageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view?.isDescendant(of: mapDetailView) ?? false)
    }
}
