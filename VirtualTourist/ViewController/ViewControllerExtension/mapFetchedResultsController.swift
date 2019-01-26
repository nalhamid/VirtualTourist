//
//  mapFetchedResultsController.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 25/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
// source: http://www.timekl.com/blog/2017/04/02/putting-core-data-on-the-map/

import UIKit
import CoreData
import MapKit

extension ViewController : NSFetchedResultsControllerDelegate {
    // Mark: setMapFetchedResultsController
    func setMapFetchedResultsController(){
        DataController.shared.viewContext.perform {
        
                //link collection view with image entity by selected pin
                let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "latitude", ascending: true)
                fetchRequest.sortDescriptors = [sortDescriptor]
                self.mapFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
                self.mapFetchedResultsController.delegate = self
                do {
                    try self.mapFetchedResultsController.performFetch()
                } catch let error{
                    print(error)
                }
            //populate map
            self.populateMap()
        }
    }
    
    // Mark: didChange
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let pin = anObject as? Pin else {
            preconditionFailure("All changes observed in the map view controller should be for Pin instances")
        }
        // create the annotation and set its coordiate
        let annotation = MKPointAnnotation()
        annotation.coordinate = pin.coordinate
        
        // switch between types
        switch type {
        case .insert:
            //add the annotations to the map
            mapView.addAnnotation(annotation)
            break
        case .delete:
            mapView.removeAnnotation(annotation)
            break
        case .update:
            mapView.removeAnnotation(annotation)
            mapView.addAnnotation(annotation)
            break
        case .move:
            // N.B. The fetched results controller was set up with a single sort descriptor that produced a consistent ordering for its fetched Point instances.
            fatalError("How did we move a Point? We have a stable sort.")
        }
    }

}
