//
//  populateMap.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 18/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//


import UIKit
// Import map kit
import MapKit
import CoreData

extension ViewController{
    // Mark: populate map
    func populateMap(){
        DispatchQueue.main.async {
            // unwrap list
            guard let mapFetchedResultsController = self.mapFetchedResultsController else {
                return
            }
            guard let pins = mapFetchedResultsController.fetchedObjects else {
                return
            }
            // array of map annotations
            var annotations = [MKPointAnnotation]()
            // loop list
            for pin in pins {
                // create the annotation and set its coordiate
                let annotation = MKPointAnnotation()
                annotation.coordinate = pin.coordinate
                // place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            //remove all annotations from the map
            self.mapView.removeAnnotations(self.mapView.annotations)
            //add the annotations to the map
            self.mapView.addAnnotations(annotations)
        }
     }

}

