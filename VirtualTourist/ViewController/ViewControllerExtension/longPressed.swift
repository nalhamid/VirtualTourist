//
//  longPressed.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 18/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
// Import map kit
import MapKit

extension ViewController {
    // Mark: Handle long Press
    // source: https://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
    @objc func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        // check if long press state finished
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            //get location
            let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
            let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            //save it the coreData
            pinViewModel.savePin(lat: newCoordinate.latitude, long: newCoordinate.longitude)
        }
    }
}
