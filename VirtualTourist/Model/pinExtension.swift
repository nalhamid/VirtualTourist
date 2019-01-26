//
//  pinExtension.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 25/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
// source: http://www.timekl.com/blog/2017/04/02/putting-core-data-on-the-map/

import CoreData
import MapKit

extension Pin: MKAnnotation {
    // add coordinate to pin entity
    public var coordinate: CLLocationCoordinate2D {
        //set latitude and longitude
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        //The lat and long are used to create a CLLocationCoordinates2D instance.
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
