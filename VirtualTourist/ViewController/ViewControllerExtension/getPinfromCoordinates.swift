//
//  getPinfromCoordinates.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 25/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import CoreData
import UIKit

extension ViewController {
    func getPinfromCoordinates(lat: Double, long: Double) -> NSManagedObjectID {
        // filter mapFetchedResultsController with coordinates
        let results =  self.mapFetchedResultsController.fetchedObjects?.filter({ (pin: Pin) -> Bool in
            return (pin.latitude == lat) && (pin.longitude == long)
        })
        //get pin id
        let pin = results!.first!
        return pin.objectID
    }
}
