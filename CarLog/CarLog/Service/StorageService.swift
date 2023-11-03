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

    func uploadImage(image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        let firebaseReference = Storage.storage().reference().child("community").child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("성공")
                firebaseReference.downloadURL { url, _ in
                    completion(url)
                }
            }
        }
    }
    
    func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, _ in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
