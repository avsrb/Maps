//
//  ViewController.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let mapView = MKMapView()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = mapView
        mapView.showsUserLocation = true
//        navigationController?.navigationBar.prefersLargeTitles = true
        //lat=55.796289&lon=49.108795
        let initialLocation = CLLocation(latitude: 55.796289, longitude: 49.108795)
        mapView.centerLocation(initialLocation)
    }
    
    

}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
