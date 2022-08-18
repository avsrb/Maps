//
//  ViewController.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private lazy var mapView = MKMapView()
    private lazy var locationManager = CLLocationManager()
    private lazy var segmentedControll : UISegmentedControl = {
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
    private lazy var locationButton : UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: segmentedControll.frame.height - 5)
        let image = UIImage(systemName: "location.fill", withConfiguration: configuration)
        button.setImage(image, for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(curentLocation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.addSubview(segmentedControll)
        mapView.addSubview(locationButton)

        view = mapView
        
        mapView.delegate = self

        mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: Place.favotite.first!.coordinate.latitude, longitude: Place.favotite.first!.coordinate.longitude)
        mapView.centerToLocation(initialLocation)
        
        segmentedControll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        segmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        locationButton.leftAnchor.constraint(equalTo: segmentedControll.rightAnchor, constant: 10).isActive = true
        locationButton.topAnchor.constraint(equalTo: segmentedControll.topAnchor).isActive = true
        
        for place in Place.favotite {
            mapView.addAnnotation(place)
        }
        
        mapView.register(PlaceView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAutorization()
        } else {
            showAlert(title: "У вас выключена служба геолокации", message: "Хотите включить?", urlString: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    
    func showAlert(title: String, message: String, urlString: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "Настройки", style: .default) { alert in
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(settingAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
      
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlert(title: "Вы запретили использование местоположения", message: "Хотите изменить это?", urlString: UIApplication.openSettingsURLString)
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
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
    
    @objc func curentLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 400, longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapViewController: PresenterToMapViewProtocol {
    func goToplace(place: Place) {
        self.tabBarController?.selectedIndex = 0
        let location = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        self.mapView.centerToLocation(location)
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else {
            return nil
        }
        let identifier = "place"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView( withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            for place in Place.favotite {
                if place.title == annotation.title {
                    view.markerTintColor = place.color
                }
            }
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView( _ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      guard let Place = view.annotation as? Place else {
        return
      }

      let launchOptions = [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
      ]
      Place.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last?.coordinate {
//            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
//            mapView.setRegion(region, animated: true)
//        }
//    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAutorization()
    }
}
