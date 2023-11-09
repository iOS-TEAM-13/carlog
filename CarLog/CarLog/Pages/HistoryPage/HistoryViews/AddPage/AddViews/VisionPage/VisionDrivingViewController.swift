//
//  VisionDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit
import Vision

// ImagePickerPurpose 열거형 정의
enum ImagePickerPurpose {
    case depart
    case arrive
}

class VisionDrivingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var visionDrivingView: VisionDrivingView = {
        let visionDrivingView = VisionDrivingView()
        return visionDrivingView
    }()

    // Vision 요청 초기화 (lazy로 변경)
    lazy var textRecognitionRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let observations = request.results as? [VNRecognizedTextObservation] {
                for observation in observations {
                    if let bestCandidate = observation.topCandidates(1).first {
                        print("Recognized Text: \(bestCandidate.string)")
                    }
                }
            }
        }
        
        request.recognitionLanguages = ["ko"]
        return request
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
        
        navigationUI()
        
        visionDrivingButtonAction()
    }
    
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToAddDrivingPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToAddDrivingPage() {
        print("비전 페이지에서 주유 추가 페이지로 뒤로간다")
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionDrivingButtonAction() {
        visionDrivingView.addDepartVisionButton.addAction(UIAction(handler: { [weak self] _ in
            print("출발 사진을 선택해주세요")
            self?.presentImagePicker(for: .depart)
        }), for: .touchUpInside)
        
        visionDrivingView.addArriveVisionButton.addAction(UIAction(handler: { [weak self] _ in
            print("도착 사진을 선택해주세요")
            self?.presentImagePicker(for: .arrive)
        }), for: .touchUpInside)
    }
    
    //UIImagePickerController 호출
    func presentImagePicker(for purpose: ImagePickerPurpose) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.imagePickerPurpose = purpose
        self.present(imagePicker, animated: true, completion: nil)
    }

    //UIImagePickerControllerDelegate 메서드 - 이미지 선택 후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // 선택된 이미지를 VisionDrivingView에 설정
            
            
            //선택된 이미지를 Vision 요청에 전달
            processImageWithVision(image: pickedImage, purpose: picker.imagePickerPurpose)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Vision으로 이미지 처리 및 텍스트 인식
    func processImageWithVision(image: UIImage, purpose: ImagePickerPurpose?) {
        if let cgImage = image.cgImage {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([textRecognitionRequest])
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

//UIImagePickerController에 ImagePickerPurpose 속성 추가
extension UIImagePickerController {
    var imagePickerPurpose: ImagePickerPurpose? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imagePickerPurpose) as? ImagePickerPurpose
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.imagePickerPurpose, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var imagePickerPurpose = "imagePickerPurpose"
    }
}
