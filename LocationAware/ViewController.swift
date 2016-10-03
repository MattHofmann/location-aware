//
//  ViewController.swift
//  LocationAware
//
//  Created by Matthias Hofmann on 03.10.16.
//  Copyright © 2016 MatthiasHofmann. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // IBOutlets
    @IBOutlet weak var map: MKMapView!
    
    // Manager
    var locationManager = CLLocationManager()
    
    // IBOutlets
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }


    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        // get user location
        
        let userLocation: CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        // set the label values
        self.latitudeLabel.text = String(latitude)
        self.longitudeLabel.text = String(longitude)
        self.courseLabel.text = String(userLocation.course)
        self.speedLabel.text = String(userLocation.speed)
        self.altitudeLabel.text = String(userLocation.altitude)

        // set adress
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                print(error)
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var adress = ""

                    if placemark.subThoroughfare != nil {
                        adress += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                        adress += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        adress += placemark.subLocality! + "\n"
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        adress += placemark.subAdministrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil {
                        adress += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil {
                        adress += placemark.country! + "\n"
                    }
                    
                    self.adressLabel.text = adress
                }
                
            }
        }
        
        // Map
        // zoomlvl of the map
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        // overall zoomlvl of the map
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)

    }
    
}

