//
//  UIImageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 11/10/23.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
            
        let cacheKey = NSString(string: url.absoluteString) // 캐시에 사용될 Key 값
            
            if let cachedImage = ImageCacheService.shared.object(forKey: cacheKey) {
                self.image = cachedImage
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                if let imageUrl = URL(string: url.absoluteString) {
                    URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                        if let _ = err {
                            DispatchQueue.main.async {
                                self.image = UIImage()
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data, let image = UIImage(data: data) {
                                ImageCacheService.shared.setObject(image, forKey: cacheKey)
                                self.image = image
                            }
                        }
                    }.resume()
                }
            }
        }
}

