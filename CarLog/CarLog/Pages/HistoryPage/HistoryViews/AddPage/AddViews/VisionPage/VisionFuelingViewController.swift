//
//  VisionFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import MobileCoreServices
import SnapKit
import Vision

class VisionFuelingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        navigationUI()
        
        visionFuelingButtonAction()
    }
    
    //MARK: - 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
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
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionFuelingButtonAction() {
        visionFuelingView.addVisionButton.addAction(UIAction(handler: { [weak self] _ in
            print("사진을 선택해주세요")
            self?.presentImagePicker()
        }), for: .touchUpInside)
    }
    
    //UIImagePickerController 호출
     func presentImagePicker() {
         let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
         imagePicker.sourceType = .photoLibrary
         self.present(imagePicker, animated: true, completion: nil)
     }

     //Vision 요청 초기화
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

     // UIImagePickerControllerDelegate 메서드 - 이미지 선택 후 호출
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let pickedImage = info[.originalImage] as? UIImage {
             //선택된 이미지를 VisionFuelingView에 설정
             visionFuelingView.setVisionImage(image: pickedImage)
             
             //선택된 이미지를 Vision 요청에 전달
             processImageWithVision(image: pickedImage)
         }

         picker.dismiss(animated: true, completion: nil)
     }

     //Vision으로 이미지 처리 및 텍스트 인식
     func processImageWithVision(image: UIImage) {
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
