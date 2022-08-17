//
//  Model.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import MapKit
import UIKit

struct Place {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var color: UIColor

    static let favotite = [
        Place(title: "Kaзань", coordinate:CLLocationCoordinate2D(latitude: 55.796289, longitude: 49.108795), info: "21 school", color: .red),
        Place(title: "Wolfsburg", coordinate:CLLocationCoordinate2D(latitude: 52.427911, longitude: 10.785847), info: "42 Wolfsburg",color: .red),
        Place(title: "USA", coordinate:CLLocationCoordinate2D(latitude: 38.899513,  longitude: -77.036527), info: "United State", color: .red),
    ]
}
