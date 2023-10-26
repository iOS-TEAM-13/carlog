import CoreLocation
import MapKit
import SnapKit
import UIKit

class MapPageViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    var stationList : [GasStationSummary] = []
    var stationDetailList: [GasStationDetailSummary] = []
    
    var gasStationDetailView: GasStationDetailView?
    
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager()
    //dummyData
    let dummyData = CLLocationCoordinate2D(latitude: 37.29611185603856, longitude: 127.05515403584008)
    
    //  private var overlayView: UIView!
    private var detailView: UIView!
    
    private lazy var myLocationButton = {
        let button = UIButton()
        if let image = UIImage(named: "currentLocate"){
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(myLocationButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private lazy var zoomInButton = {
        let button = UIButton()
        if let image = UIImage(named: "zoomin"){
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private lazy var zoomOutButton = {
        let button = UIButton()
        if let image = UIImage(named: "zoomout"){
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private func addDummyPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = dummyData
        mapView.addAnnotation(pin)
    }
    
    private lazy var mapDetailView: GasStationDetailView = {
        let view = GasStationDetailView()
        view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 250)
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        mapView.delegate = self
        locationManager.delegate = self
        
        mapView.setRegion(MKCoordinateRegion(center: dummyData, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideDetailView(_:)))
        mapView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
        gasStationDetailView = GasStationDetailView()
        
        setupMapView()
        getLocationUsagePermission()
        addDummyPin()
        setupLocationManager()
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        view.addSubview(myLocationButton)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        self.view.addSubview(mapDetailView)
        
        
        // 나침반 표시 여부
        mapView.showsCompass = true
        // 축척 정보 표시 여부
        mapView.showsScale = true
        // 위치 사용 시 사용자의 연재 위치 표시
        mapView.showsUserLocation = true
        // 사용자 위치를 표시하고 사용자가 움직일 때마다 지도도 함께 움직여 사용자의 현재 위치를 중심으로 유지
        //mapView.setUserTrackingMode(.follow, animated: true)
        //사용자의 방향에 따라 회전(나침반 기능과 함께 사용)
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        mapView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
        }
        
        // 어노테이션 뷰 초기 설정 (이미지 등)은 여기에서 합니다.
        // 실제 어노테이션 뷰 업데이트는 regionDidChangeAnimated에서 처리합니다.
        annotationView?.isUserInteractionEnabled = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if mapView.region.span.latitudeDelta < 0.01 {
            for annotation in mapView.annotations {
                if let annotationView = mapView.view(for: annotation), !(annotation is MKUserLocation) {
                    updateAnnotationToCustomView(annotationView, annotation: annotation)
                }
            }
        } else {
            for annotation in mapView.annotations {
                if let annotationView = mapView.view(for: annotation), !(annotation is MKUserLocation) {
                    updateAnnotationToPin(annotationView)
                }
            }
        }
    }
    //디테일 뷰 상단만 코너래디우스 주기
    func applyTopCornersRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        view.layer.mask = mask
    }
    // 어노테이션 클릭 시 관련 코드
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("어노테이션이 클릭되었습니다.")
        if let _ = view.annotation as? MKPointAnnotation {
            // 어노테이션을 클릭했을 때 detailView 나오게 함
            UIView.animate(withDuration: 0.1) {
                self.mapDetailView.frame = CGRect(x: 0, y: self.view.bounds.height - 250 - self.view.safeAreaInsets.bottom, width: self.view.bounds.width, height: 250) // 높이와 y 위치를 200으로 변경
                mapView.deselectAnnotation(view.annotation, animated: false)
            }
            self.applyTopCornersRadius(to: self.mapDetailView, radius: 15)
        }
        
        
    }
    
    func updateAnnotationToCustomView(_ annotationView: MKAnnotationView, annotation: MKAnnotation) {
        annotationView.image = nil
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        
        let label = UILabel(frame: view.bounds)
        label.text = "휘발유:2000원 \n경유: 1400원"
        label.font = UIFont(name: "Jua", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        
        annotationView.addSubview(view)
        annotationView.frame = view.frame
    }
    
    func updateAnnotationToPin(_ annotationView: MKAnnotationView) {
        for subview in annotationView.subviews {
            subview.removeFromSuperview()
        }
        annotationView.image = UIImage(named: "pin")
    }
    
    // 현재위치 버튼 입력 시 동작
    @objc func myLocationButtonTapped() {
        
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    // +버튼 입력 시 동작
    @objc func zoomInButtonTapped() {
        let zoom = 0.5 // 원하는 축척 변경 비율
        let region = mapView.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.setRegion(newRegion, animated: true)
    }
    // -버튼 입력 시 동작
    @objc func zoomOutButtonTapped() {
        let zoom = 2.0 // 원하는 축척 변경 비율
        let region = mapView.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.setRegion(newRegion, animated: true)
    }
    
    func getLocationUsagePermission() {
        //location4
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //location5
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation() // 중요!
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
    
    @objc func handleTapOutsideDetailView(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.view)
        if !mapDetailView.frame.contains(location) {
            // mapDetailView 바깥 영역을 탭했을 경우
            hideDetailView()
        }
    }
    
    func hideDetailView() {
        UIView.animate(withDuration: 0.3) {
            self.mapDetailView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 200)
        }
    }
    //MARK : FETCH DATA
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            fetchCoordinateCurrentLocation(currentLocation)
        }
        //            if let currentLocation = locations.last {
        //                        locationManager.stopUpdatingLocation()  // 위치 정보 업데이트 중지
        //                        fetchList(x: currentLocation.coordinate.latitude, y: currentLocation.coordinate.longitude)
        //                    }
    }
    //WGS 좌표 -> KATECH 좌표
    
    func fetchCoordinateCurrentLocation(_ location: CLLocation) {
        
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        
        networkManager.fetchCoordinateChange(fromLat: lat, fromLon: lon) { coordinate in
            DispatchQueue.main.async {  // 메인 스레드에서 실행
                if let coordinate = coordinate {
                    print("현 위치:" + "Longitude: \(coordinate.coordinate.lon), Latitude: \(coordinate.coordinate.lat)")
                    // 여기서 UI 업데이트 등의 작업을 수행할 수 있습니다.
                    self.fetchList(x: coordinate.coordinate.lon, y: coordinate.coordinate.lat)
                } else {
                    print("Failed to fetch coordinate")
                    // 에러 상황에 대한 처리를 수행할 수 있습니다.
                }
            }
        }
    }
    //반경 내 주유소 api request
    
    func fetchList(x: String, y: String) {
        networkManager.fetchGasStationList(x: x, y: y, sort: "1", prodcd: "B027") { listResponse in
            DispatchQueue.main.async {
                if let listResponse = listResponse {
                    self.stationList.append(contentsOf: listResponse.result.oil)
                    self.fetchGasStationDetail()
                    // print(self.stationList)
                    // 여기에서 UI를 업데이트하거나 다른 처리를 할 수 있습니다.
                } else {
                    print("데이터 로딩 실패")
                }
            }
        }
    }

    func fetchGasStationDetail() {
        stationList.map{ $0.uniID}.forEach { id in
            networkManager.fetchGasStationDetailList(id: id) {gasStationResponse in
                if let gasStationResponse = gasStationResponse {
                    for i in 0...gasStationResponse.result.oil.count - 1 {
                        self.stationDetailList.append(gasStationResponse.result.oil[i])
                        self.fetchCoordinateCurrentLocationAgain(fromLat: String(gasStationResponse.result.oil[i].gisXCoor), fromLon: String(gasStationResponse.result.oil[i].gisYCoor), index: i)
                    }
                } else {
                    print("실패")
                }
            }
        }
    }
    
    //KATECH->WGS84
    func fetchCoordinateCurrentLocationAgain(fromLat: String, fromLon: String, index: Int) {
        networkManager.fetchCoordinateChangeAgain(fromLat: fromLat, fromLon: fromLon) { coordinate in
            DispatchQueue.main.async {  // 메인 스레드에서 실행
                if let coordinate = coordinate {
                    // 여기서 UI 업데이트 등의 작업을 수행할 수 있습니다.
                        self.stationDetailList[index].gisXCoor = Float(coordinate.coordinate.lon) ?? 0.0
                        self.stationDetailList[index].gisYCoor = Float(coordinate.coordinate.lat) ?? 0.0
                    print(self.stationDetailList[index].gisXCoor)
                } else {
                    print("Failed to fetch coordinate")
                    // 에러 상황에 대한 처리를 수행할 수 있습니다.
                }
                // 여기서 stationDetailList로 어노테이션 띄우고 데이터 매핑해주세요
            }
        }
    }
}
    
    extension MapPageViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            return !(touch.view?.isDescendant(of: mapDetailView) ?? false)
        }
    }
