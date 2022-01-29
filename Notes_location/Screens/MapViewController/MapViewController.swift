//
//  MapViewController.swift
//  Notes_location
//
//  Created by admin on 29/1/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapNameLabel: UILabel!
    
    let manager = CLLocationManager()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //       manager.desiredAccuracy = kCLLocationAccuracyBest
        //       manager.delegate = self
        //       manager.requestWhenInUseAuthorization()
        //       manager.startUpdatingLocation()
        //
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    // https://stackoverflow.com/questions/27735835/convert-coordinates-to-city-name
    func positionLocation(_ gestureRecognizer: UITapGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate
        annotation.title = "Your position"
        mapView.addAnnotation(annotation) //drops the pin
        print("lat:  \(touchCoordinate.latitude)")
        let num = touchCoordinate.latitude as NSNumber
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        _ = formatter.string(from: num)
        print("long: \(touchCoordinate.longitude)")
        let num1 = touchCoordinate.longitude as NSNumber
        let formatter1 = NumberFormatter()
        formatter1.maximumFractionDigits = 4
        formatter1.minimumFractionDigits = 4
        _ = formatter1.string(from: num1)
        //                self.adressLoLa.text = "\(num),\(num1)"
        print("\(num),\(num1)")
        
        coordinatesLocationType(touchCoordinate)
    }
    
    // Add below code to get address for touch coordinates.
    func coordinatesLocationType(_ touchCoordinate:  CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
            
            // Place details
            guard let placeMark = placemarks?.first else { return }
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print(street)
                self.mapNameLabel.text = street
                
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                print(city)
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print(zip)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
        })
    }
}

extension MapViewController {
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        positionLocation(gestureRecognizer)
    }
}
