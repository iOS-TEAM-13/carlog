//
//  CustomAnnotation.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/02.
//

import UIKit

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var gasolineImage: UIImage?
    var dieselImage: UIImage?
    var gasolinePrice: String?
    var dieselPrice: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String? = nil, gasolineImage: UIImage? = nil, dieselImage: UIImage? = nil, gasolinePrice: String? = nil, dieselPrice: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.gasolineImage = gasolineImage
        self.dieselImage = dieselImage
        self.gasolinePrice = gasolinePrice
        self.dieselPrice = dieselPrice
        self.coordinate = coordinate
    }
}
