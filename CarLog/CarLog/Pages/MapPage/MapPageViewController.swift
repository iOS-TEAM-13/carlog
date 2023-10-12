import CoreLocation
import MapKit
import SnapKit
import UIKit

class MapPageViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    
    var locationManager = CLLocationManager()
    //dummyData
    let dummyData = CLLocationCoordinate2D(latitude: 37.29611185603856, longitude: 127.05515403584008)
    
    private lazy var myLocationButton = {
        let button = UIButton()
        if let image = UIImage(named: "현재 위치 버튼"){
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
    
    private lazy var dummyButton = {
        let button = UIButton()
        if let image = UIImage(named: "zoomout"){
            button.setImage(image, for: .normal)
           // button.addTarget(self, action: #selector(dummyButtonTapped), for: .touchUpInside)
        }
        return button
    }()
    
    private func addDummyPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = dummyData
        pin.title = "광교 SK 주유소"
        pin.subtitle = "휘발유: 1804원, 경유: 1455원"
        mapView.addAnnotation(pin)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        mapView.delegate = self
        locationManager.delegate = self
        
        mapView.setRegion(MKCoordinateRegion(center: dummyData, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        setupMapView()
        getLocationUsagePermission()
        addDummyPin()
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        view.addSubview(myLocationButton)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        //view.addSubview(dummyButton) //모달 불러오는 더미 버튼
        
        
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
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "pin")
        
        return annotationView
    }
    
    @objc func myLocationButtonTapped() {
        
        guard let currentLocation = locationManager.location else {
                locationManager.requestWhenInUseAuthorization()
                return
            }
            let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    
    @objc func zoomInButtonTapped() {
        let zoom = 0.5 // 원하는 축척 변경 비율
         let region = mapView.region
         let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
         let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
         mapView.setRegion(newRegion, animated: true)
    }
    
    @objc func zoomOutButtonTapped() {
        let zoom = 2.0 // 원하는 축척 변경 비율
           let region = mapView.region
           let newSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoom, longitudeDelta: region.span.longitudeDelta * zoom)
           let newRegion = MKCoordinateRegion(center: region.center, span: newSpan)
           mapView.setRegion(newRegion, animated: true)
    }
    
    //더미 버튼
//    @objc func dummyButtonTapped() {
//    }
    
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
    
}
