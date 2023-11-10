//
//  VisionDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit
import Vision

//MARK: - 출발, 도착 케이스
enum ImageType {
    case depart
    case arrival
}

//MARK: - addpage로 넘길 출발, 도착, 운행거리 자동계산
extension Notification.Name {
    static let visionDepart = Notification.Name("visionDepart")
    static let visionArrive = Notification.Name("visionArrive")
    static let visionDrive = Notification.Name("visionDrive")
}

class VisionDrivingViewController: UIViewController {
    
    lazy var visionDrivingView: VisionDrivingView = {
        let visionDrivingView = VisionDrivingView()
        return visionDrivingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(visionDrivingView)
        visionDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        //네비
        navigationUI()
        
        //버튼액션
        visionDrivingButtonAction()
    }
    
    //빈 화면 클릭 시 키보드 내리는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        visionDrivingView.endEditing(true)
    }
    
    //MARK: - 주행 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.okButton
    }
    
    //네비게이션 뒤로가기 버튼
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToAddDrivingPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToAddDrivingPage() {
        print("비전 페이지에서 주유 추가 페이지로 뒤로간다")
        navigationController?.popViewController(animated: true)
    }
    
    //네비게이션 확인 버튼
    lazy var okButton: UIBarButtonItem = {
        let okButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(goToAddDrivingPageWithData))
        okButton.tintColor = .mainNavyColor
        return okButton
    }()
    
    @objc func goToAddDrivingPageWithData() {
        print("비전 페이지에서 주유 추가 페이지로 뒤로간다")
        
        //add페이지로 연결할 출발 데이터
        if let departText = visionDrivingView.visionDepartTextField.text {
            NotificationCenter.default.post(name: .visionDepart, object: departText)
        }
        
        //add페이지로 연결할 도착 데이터
        if let arriveText = visionDrivingView.visionArriveTextField.text {
            NotificationCenter.default.post(name: .visionArrive, object: arriveText)
        }
        
        //add페이지로 연결할 도착-출발 운행 데이터 계산해서 가지고 있다 넘길거
        let depart = Int(visionDrivingView.visionDepartTextField.text ?? "") ?? 0
        let arrive = Int(visionDrivingView.visionArriveTextField.text ?? "") ?? 0
        let driveText = arrive - depart
        NotificationCenter.default.post(name: .visionDrive, object: String(driveText))

        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionDrivingButtonAction() {
        visionDrivingView.visionDepartImageButton.addAction(UIAction(handler: { _ in
            print("출발사진 선택 클릭")
            self.selectImageAndRecognizeText(from: .depart)
        }), for: .touchUpInside)
        
        visionDrivingView.visionArriveImabeButton.addAction(UIAction(handler: { _ in
            print("도착사진 선택 클릭")
            self.selectImageAndRecognizeText(from: .arrival)
        }), for: .touchUpInside)
    }
    
    var currentImageType: ImageType?
    
    func selectImageAndRecognizeText(from type: ImageType) {
        currentImageType = type
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

//MARK: - 이미지 선택, 선택한 이미지에서 문자 찾아서 텍스트필드에 넣기
extension VisionDrivingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var resizedImage: UIImage? = nil
        
        //이미지 리사이징
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            resizedImage = pickedImage.resized(toWidth: 150)
            switch currentImageType {
            case .depart:
                visionDrivingView.visionDepartImageButton.imageView?.contentMode = .scaleAspectFill
                visionDrivingView.visionDepartImageButton.setImage(resizedImage, for: .normal)
            case .arrival:
                visionDrivingView.visionArriveImabeButton.imageView?.contentMode = .scaleAspectFill
                visionDrivingView.visionArriveImabeButton.setImage(resizedImage, for: .normal)
            case .none: break
            }
            recognizeText(in: resizedImage ?? UIImage(), for: currentImageType!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func recognizeText(in image: UIImage, for type: ImageType) {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up)
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition failed with error: \(error?.localizedDescription ?? "")")
                return
            }
            
            var recognizedText = ""
            
            //
            for observation in observations {
                if let bestCandidate = observation.topCandidates(1).first {
                    print("Recognized Text: \(bestCandidate.string)")
                    recognizedText += bestCandidate.string
                    print("-- Recognized Text: \(recognizedText)")
                }
            }
            
            //
            DispatchQueue.main.async {
                switch type {
                case .depart:
                    //ODO와 KM 사이의 문자 추출
                    if let odoRange = recognizedText.range(of: "ODO"),
                       let kmRange = recognizedText.range(of: "km"),
                       odoRange.upperBound < kmRange.lowerBound {
                        let odoEndIndex = odoRange.upperBound
                        let kmStartIndex = kmRange.lowerBound
                        let betweenText = recognizedText[odoEndIndex..<kmStartIndex]
                        
                        print("ODO와 KM 사이의 문자: \(betweenText)")
                        self?.visionDrivingView.visionDepartTextField.text = String(betweenText)
                    } else {
                        print("ODO 또는 km이 인식되지 않았거나, 그 사이의 문자열을 찾을 수 없습니다.")
                        self?.visionDrivingView.visionDepartTextField.text = "다시"
                    }
                case .arrival:
                    //ODO와 KM 사이의 문자 추출
                    if let odoRange = recognizedText.range(of: "ODO"),
                       let kmRange = recognizedText.range(of: "km"),
                       odoRange.upperBound < kmRange.lowerBound {
                        let odoEndIndex = odoRange.upperBound
                        let kmStartIndex = kmRange.lowerBound
                        let betweenText = recognizedText[odoEndIndex..<kmStartIndex]
                        
                        print("ODO와 KM 사이의 문자: \(betweenText)")
                        self?.visionDrivingView.visionArriveTextField.text = String(betweenText)
                    } else {
                        print("ODO 또는 km이 인식되지 않았거나, 그 사이의 문자열을 찾을 수 없습니다.")
                        self?.visionDrivingView.visionArriveTextField.text = "다시"
                    }
                }
            }
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error in text recognition: \(error.localizedDescription)")
        }
    }
    
}

//MARK: - 이미지 크기 조정
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

