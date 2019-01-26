//
//  PinsViewModel.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 18/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
import CoreData

class PinsViewModel {
    // Mark Variables
    var pins : [Pin] = []
    var photosViewModel = PhotosViewModel()
    
    // Mark: save pin
    func savePin(lat: Double, long: Double) {
        DataController.shared.persistentContainer.performBackgroundTask({ (context) in
            let pin = Pin(context: context)
            pin.latitude = lat
            pin.longitude = long
            // save to context
            try? context.save()
            // get images for the added pin
            self.photosViewModel.getImages(pin: pin) { (success, message) in
            }
        })
    }
    
}
