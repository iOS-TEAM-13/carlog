//
//  ImageCacheService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

class ImageCacheService {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
