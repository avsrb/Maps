//
//  PlaceView.swift
//  Maps
//
//  Created by Artem Serebriakov on 18.08.2022.
//

import Foundation
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard newValue is Place else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            // 2
//            markerTintColor = Place.markerTintColor
//            glyphImage = Place.image
        }
    }
}

class PlaceView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let Place = newValue as? Place else {
                return
            }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
//            image = Place.image
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = Place.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
