//
//  LocationConverter.swift
//  GeoCoderConversion
//
//  Created by Abhinay Vangipuram on 1/29/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import CoreLocation

class LocationConverter: NSObject {
    
    // MARK: Get Placemarks from coordinates and zip code
    
    func getZipCodeForCurrentLocation(userLocation: CLLocation,
                                      completionHandler: @escaping (_ placeMark: CLPlacemark?)
        -> Void ) {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(userLocation,
                                        completionHandler: { (placemarks, error) in
                                            if error == nil {
                                                let firstLocation = placemarks?[0]
                                                completionHandler(firstLocation)
                                            }
                                            else {
                                                // An error occurred during geocoding.
                                                completionHandler(nil)
                                            }
        })
    }
    
    func getCoordinatesForZipCode( addressString : String,
                                   completionHandler: @escaping(_ coordintes: CLLocationCoordinate2D, _ error: NSError?) -> Void ) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
