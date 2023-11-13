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
    var myLatitude: CLLocationDegrees?
    var myLongitude: CLLocationDegrees?

    // MARK: Data
    var data: CustomGasStation?
    private lazy var stationDetailList: [CustomGasStation] = []
    private lazy var locationList: [CustomAnnotation] = []
    
    // MARK: LifeCycle
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.map.delegate = self
        locationManager.delegate = self
        
        setupMapView()
        addCustomPin()
        addButtonActions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        setAuthorization()
        setupLocationManager()
    }
    
    // MARK: Method
    private func setupMapView() {
        view.addSubview(guideView)
        
        mapView.map.showsCompass = true
        mapView.map.showsScale = true
        mapView.map.showsUserLocation = false
        
        guideView.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.size.equalTo(100)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.map.setUserTrackingMode(.followWithHeading, animated: true)
        if let currentLocation = locations.last {
            myLatitude = currentLocation.coordinate.latitude
            myLongitude = currentLocation.coordinate.longitude
            fetchCoordinateCurrentLocation(currentLocation)
            if let lat = myLatitude, let lon = myLongitude {
                mapView.map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
            }
        }
    }
    
    private func fetchCoordinateCurrentLocation(_ location: CLLocation) {
        let lat = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).x)
        let lon = String(INVKatec(latLng: INVLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)).y)
        fetchNearByList(x: lat, y: lon)
    }
    
    private func fetchNearByList(x: String, y: String) {
        NetworkService.service.fetchNearbyGasStation(x: x, y: y, sort: "2", prodcd: "B027") { [weak self] data in
            if let data = data {
                self?.fetchDetailGasStation(id: data)
            }
        }
    }
    
    private func fetchDetailGasStation(id: [String]) {
        NetworkService.service.fetchDetailGasStation(idList: id) { [weak self] data in
            if let data = data {
                self?.stationDetailList = data
                self?.changeAdress(gasStation: data) {
                    self?.stationDetailList.forEach { item in
                        self?.locationList.append(CustomAnnotation(title: item.name, gasolinePrice: String(item.oilPrice.filter { $0.prodcd == "B027" }.first?.price ?? 0), dieselPrice: String(item.oilPrice.filter { $0.prodcd == "D047" }.first?.price ?? 0), coordinate: CLLocationCoordinate2D(latitude: Double(item.gisYCoor), longitude: Double(item.gisXCoor))))
                        self?.addCustomPin()
                        self?.locationManager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    
    private func changeAdress(gasStation: [CustomGasStation], completion: @escaping () -> Void) {
        NetworkService.service.changeAddress(gasStation: gasStation) { [weak self] data in
            if data?.count != 0 {
                if let data = data {
                    self?.stationDetailList = data
                }
                completion()
            }
        }
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
        
        mapView.myLocationButton.addTarget(self, action: #selector(myLocationButtonTapped), for: .touchUpInside)
        mapView.zoomInButton.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        mapView.zoomOutButton.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
    }
    
    private func setAuthorization() {
        let status = locationManager.authorizationStatus
        if status == .denied || status == .restricted {
            DispatchQueue.main.async {
                self.moveToSettingAlert(reason: "위치 권한 요청 거부됨", discription: "설정에서 권한을 허용해 주세요.")
            }
        }
    }
    
    private func moveToSettingAlert(reason: String, discription: String) {
        let alert = UIAlertController(title: reason, message: discription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        cancle.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: @Objc
    @objc func myLocationButtonTapped() {
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.map.setRegion(region, animated: true)
    }
    
    @objc func zoomInButtonTapped() {
        let zoom = 0.5
        let region = mapView.map.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.map.setRegion(newRegion, animated: true)
    }
    
    @objc func zoomOutButtonTapped() {
        let zoom = 2.0
        let region = mapView.map.region
        let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
        let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
        mapView.map.setRegion(newRegion, animated: true)
    }
}

extension MapPageViewController: MKMapViewDelegate {
    func setupAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomAnnotationView.self), for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        var annotationView: MKAnnotationView?
        
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var data: CustomGasStation?
        stationDetailList.forEach { station in
            if station.name == mapView.selectedAnnotations.first?.title {
                data = station
            }
        }
        if let data = data {
            self.data = data
            
            let vc = GasStationDetailViewController(data: data)
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MapPageViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            locationManager.startUpdatingLocation() // 중요!
        default:
            DispatchQueue.main.async {
                self.moveToSettingAlert(reason: "위치 권한 요청 거부됨", discription: "설정에서 권한을 허용해 주세요.")
            }
            print("GPS: Default")
        }
    }
}

extension MapPageViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting, size: 0.4)
    }
}
