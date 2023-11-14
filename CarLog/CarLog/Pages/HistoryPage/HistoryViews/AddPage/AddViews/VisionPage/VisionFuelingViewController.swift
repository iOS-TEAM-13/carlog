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
    
    func moveToSettingAlert(reason: String, discription: String) {
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
            
            var recognizedText = ""
            
            //
//            for observation in observations {
//                if let bestCandidate = observation.topCandidates(1).first {
//                    print("Recognized Text: \(bestCandidate.string)")
//                    recognizedText += bestCandidate.string
//                    print("-- Recognized Text: \(recognizedText)")
//                }
//            }
            for observation in observations {
                if let bestCandidate = observation.topCandidates(1).first {
                    print("Recognized Text: \(bestCandidate.string)")
                }
            }
            
            //
            DispatchQueue.main.async {
//                if let xLeftRange = recognizedText.range(of: "단가") {
//                    let priceText = recognizedText[xLeftRange]
//                    print("\(priceText)")
//                    self?.visionFuelingView.visionPriceTextField.text = String(priceText)
//                }
//                
//                if let xRightRange = recognizedText.range(of: "x") {
//                    let countText = recognizedText[xRightRange]
//                    print("\(countText)")
//                    self?.visionFuelingView.visionCountTextField.text = String(countText)
//                }
                
                if let xRange = recognizedText.range(of: "X"),
                   let leftBound = recognizedText.index(xRange.lowerBound, offsetBy: -4, limitedBy: recognizedText.startIndex),
                   let rightBound = recognizedText.index(xRange.upperBound, offsetBy: 5, limitedBy: recognizedText.endIndex) {
                    
                    let leftText = recognizedText[leftBound..<xRange.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                    let rightText = recognizedText[xRange.upperBound..<rightBound].trimmingCharacters(in: .whitespacesAndNewlines)

                    print("Left Text: \(leftText)")
                    print("Right Text: \(rightText)")

                    // 각각의 텍스트 필드에 할당
                    self?.visionFuelingView.visionPriceTextField.text = leftText
                    self?.visionFuelingView.visionCountTextField.text = rightText
                }
                
                
            }
        }
        
        //
        request.recognitionLanguages = ["ko"]
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error in text recognition: \(error.localizedDescription)")
        }
    }
    
}
