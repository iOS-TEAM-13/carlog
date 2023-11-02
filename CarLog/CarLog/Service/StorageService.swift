//
//  StorageService.swift
//  CarLog
//
//  Created by 김은경 on 11/2/23.
//
import UIKit

import FirebaseStorage

class StorageService {
    static let storageService = StorageService()

    func uploadImage2(image: UIImage) {
        var imageData = Data()
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let filePath = "community"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        Storage.storage().reference().child(filePath).putData(imageData, metadata: metaData){ metaData, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("성공")
            }
        }
    }
    
    func uploadImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
            guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
            
            let firebaseReference = Storage.storage().reference().child("\(imageName)")
            firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("성공")
                }
            }
        }
}
