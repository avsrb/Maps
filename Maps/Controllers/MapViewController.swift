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
    let segmentedControll : UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.selectedSegmentTintColor = .systemBlue
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.backgroundColor = .white
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .normal)
        segmentedControll.addTarget(self, action: #selector(changeMapViewType(_:)), for: .valueChanged)
        return segmentedControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
        mapView.addSubview(segmentedControll)
        view = mapView
        mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: 55.796289, longitude: 49.108795)
        mapView.centerLocation(initialLocation)
        
        segmentedControll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        segmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func changeMapViewType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            print(sender.selectedSegmentIndex)
        }
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

extension MapViewController: PresenterToMapViewProtocol {
    func goToplace(place: Place) {
        self.tabBarController?.selectedIndex = 0
        let center = place.coordinate
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else {
            return nil
        }
        let identifier = "place"
        let view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "place") as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? Place else {
            return
        }
        
        let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        
    }
}
