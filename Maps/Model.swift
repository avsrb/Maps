//
//  Model.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import MapKit
import UIKit

class Place: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var color: UIColor
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, color: UIColor = .red) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.color = color
    }

    static let favotite = [
        Place(title: "Kaзань", coordinate:CLLocationCoordinate2D(latitude: 55.796289, longitude: 49.108795), info: "21 school"),
        Place(title: "Wolfsburg", coordinate:CLLocationCoordinate2D(latitude: 52.427911, longitude: 10.785847), info: "42 Wolfsburg"),
        Place(title: "USA", coordinate:CLLocationCoordinate2D(latitude: 38.899513,  longitude: -77.036527), info: "United State"),
    ]
}
