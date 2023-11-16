//
//  VisionFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit
import Vision
import Photos

//MARK: - addpage로 넘길 출발, 도착, 운행거리 자동계산
extension Notification.Name {
    static let visionPrice = Notification.Name("visionPrice")
    static let visionCount = Notification.Name("visionCount")
    static let visionTotalPrice = Notification.Name("visionTotalPrice")
}

class VisionFuelingViewController: UIViewController, UITextFieldDelegate {
    
    lazy var visionFuelingView: VisionFuelingView = {
        let visionFuelingView = VisionFuelingView()
        return visionFuelingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(visionFuelingView)
        visionFuelingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        //네비
        navigationUI()
        
        //visionDrivingView에 텍스트 필드 글자수 제한 설정 시
        visionFuelingView.visionPriceTextField.delegate = self
        visionFuelingView.visionCountTextField.delegate = self
        visionFuelingView.visionTotalPriceTextField.delegate = self
        
        //버튼액션
        visionFuelingButtonAction()
    }
    
    //빈 화면 클릭 시 키보드 내리는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        visionFuelingView.endEditing(true)
    }
    
    //MARK: - 주유 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.okButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToAddFuelingPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToAddFuelingPage() {
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
        print("비전 페이지에서 주행 추가 페이지로 뒤로간다")
        
        //add페이지로 연결할 단가 데이터
        if let priceText = visionFuelingView.visionPriceTextField.text {
            NotificationCenter.default.post(name: .visionPrice, object: priceText)
        }
        
        //add페이지로 연결할 수량 데이터
        if let countText = visionFuelingView.visionCountTextField.text {
            NotificationCenter.default.post(name: .visionCount, object: countText)
        }
        
        //add페이지로 연결할 금액 데이터
        if let totalPriceText = visionFuelingView.visionTotalPriceTextField.text {
            NotificationCenter.default.post(name: .visionTotalPrice, object: totalPriceText)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - 텍스트필드 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        //텍스트필드 마다 다른 글자수 제한 설정
        switch textField {
        case visionFuelingView.visionCountTextField, visionFuelingView.visionTotalPriceTextField:
            let maxLength = 6
            return updatedText.count <= maxLength
        case visionFuelingView.visionPriceTextField:
            let maxLength = 4
            return updatedText.count <= maxLength
        default:
            return true
        }
    }
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionFuelingButtonAction() {
        visionFuelingView.visionReceiptImageButton.addAction(UIAction(handler: { _ in
            print("영수증사진 선택 클릭")
            self.selectImageAndRecognizeText()
        }), for: .touchUpInside)
    }
    
    func selectImageAndRecognizeText() {
        checkAlbumPermission()
    }
    
    func checkAlbumPermission() { // 앨범 권한 허용 거부 요청
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Album: 권한 허용")
                DispatchQueue.main.async {
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.allowsEditing = true
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            default:
                DispatchQueue.main.async {
                    self.moveToSettingAlert(reason: "사진 접근 요청 거부됨", discription: "설정에서 권한을 허용해 주세요.")
                }
            }
        }
    }
}

//MARK: - 이미지 선택, 선택한 이미지에서 문자 찾아서 텍스트필드에 넣기
extension VisionFuelingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var resizedImage: UIImage? = nil
        
        //이미지 리사이징
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            resizedImage = pickedImage.resized(toWidth: 150)
            
            visionFuelingView.visionReceiptImageButton.imageView?.contentMode = .scaleAspectFill
            visionFuelingView.visionReceiptImageButton.setImage(resizedImage, for: .normal)
            
            recognizeText(in: resizedImage ?? UIImage())
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func recognizeText(in image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up)
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition failed with error: \(error?.localizedDescription ?? "")")
                return
            }
            
            for observation in observations {
                if let bestCandidate = observation.topCandidates(1).first {
                    print("Recognized Text: \(bestCandidate.string)")
                    let recognizedText = bestCandidate.string
                    let components = recognizedText.components(separatedBy: "X")
                    
                    if components.count == 2 {
                        let priceText = components[0].trimmingCharacters(in: .whitespaces)
                        let price = priceText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
                        DispatchQueue.main.async {
                            self?.visionFuelingView.visionPriceTextField.text = price
                        }
                        
                        let countText = components[1]
                        let countRegex = try! NSRegularExpression(pattern: "[0-9]+(\\.[0-9]+)?", options: [])
                        let countMatches = countRegex.matches(in: countText, options: [], range: NSRange(location: 0, length: countText.utf16.count))

                        if let countMatch = countMatches.first {
                            let countRange = countMatch.range
                            var count = (countText as NSString).substring(with: countRange)
                            
                            if count.hasSuffix(".000") {
                                count = String(count.dropLast(4))
                            }
                            
                            DispatchQueue.main.async {
                                self?.visionFuelingView.visionCountTextField.text = count
                            }
                            
                            //수량에 소수점이 있다면 반올림 처리
                            if count.range(of: ".") != nil {
                                let count = Double(count) ?? 0
                                let totalPriceText = round((Double(price) ?? 0) * count * 0.1) / 0.1
                                self?.visionFuelingView.visionTotalPriceTextField.text = String(format: "%.0f", totalPriceText)
                            } else {
                                //아니면 그냥 곱하기
                                let count = Int(count) ?? 0
                                let totalPriceText = count * (Int(price) ?? 0)
                                self?.visionFuelingView.visionTotalPriceTextField.text = String(totalPriceText)
                            }
                        }
                    }
                }
            }
        }
        
        //한국어 인식
        request.recognitionLanguages = ["ko"]
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error in text recognition: \(error.localizedDescription)")
        }
    }
}
