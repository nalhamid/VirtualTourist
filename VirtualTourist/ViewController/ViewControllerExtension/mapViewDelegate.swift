//
//  mapViewExtension.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 07/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
// Import map kit
import MapKit

extension ViewController : MKMapViewDelegate{
    // Mark: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // set pin settings
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    // Mark: Tapped pin
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                // get pin
                let pinId = self.getPinfromCoordinates(lat: coordinate.latitude, long: coordinate.longitude)
                let pin = DataController.shared.viewContext.object(with: pinId) as! Pin
                // check if there are images for pin
                if(!self.photosViewModel.isThereImages(pin: pin)){
                    // get images if there are no images
                    DispatchQueue.main.async {
                        self.photosViewModel.getImages(pin: pin, completion: { (success, message) in
                            if(success){
                                print("there images")
                            }else {
                                self.showAlert(title: "Error", message: message)
                            }
                        })
                    }
                }
                // go to second screen while downloading
                self.activityIndicator.stopAnimating()
                // get photo album controller
                guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "viewAlbum") as? PhotoAlbumViewController else {
                    return
                }
                // send to second screen
                controller.pin = pin
                self.navigationController?.pushViewController(controller, animated: true)
            }
            
        }
        
    }
}
