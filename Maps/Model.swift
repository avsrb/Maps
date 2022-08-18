//
//  Model.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import MapKit
import UIKit

class Place: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    let color: UIColor
    
    init(title: String?, locationName: String?, discipline: String?, coordinate: CLLocationCoordinate2D, color: UIColor = .red) {
      self.title = title
      self.locationName = locationName
      self.discipline = discipline
      self.coordinate = coordinate
      self.color = color
      super.init()
    }

    var subtitle: String? {
      return locationName
    }
    
    
    static let favotite = [
        Place(title: "Kaзань",
              locationName: "School21",
              discipline: "👨‍💻",
              coordinate: CLLocationCoordinate2D(latitude: 55.796289, longitude: 49.108795),
              color: .green),
        Place(title: "42",
              locationName: "Wolfsburg",
              discipline: "🛩",
              coordinate: CLLocationCoordinate2D(latitude: 52.428048, longitude: 10.790464),
              color: .black),
        Place(title: "Дом Ксюши",
              locationName: "Тольятти",
              discipline: "😅",
              coordinate: CLLocationCoordinate2D(latitude: 53.484884, longitude: 49.464900),
              color: .systemPink),
        Place(title: "Челябинск",
              locationName: "Тольятти",
              discipline: "🚂",
              coordinate: CLLocationCoordinate2D(latitude: 55.159902, longitude: 61.402554),
              color: .orange),
        Place(title: "Энрики",
              locationName: "Тбилиси",
              discipline: "🍇",
              coordinate: CLLocationCoordinate2D(latitude: 41.706844, longitude: 44.806439),
              color: .opaqueSeparator),
        
    ]
}
