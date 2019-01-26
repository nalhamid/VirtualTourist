//
//  PhotosViewModel.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 18/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
import CoreData

class PhotosViewModel {
    
    // Mark: get images
    func getImages(pin: Pin, completion: @escaping (Bool, String)->()){
        
        FlickrAPI.sharedInstance().getPhotosByLocation(lat: pin.latitude, long: pin.longitude) { (photos, success, message) in
            // check if success
            if(success){
                self.downloadList(list: photos, pin: pin)
            }
            completion(success, message)
        }
    }
    
    // Mark: SaveImageForPin
    func SaveImageForPin(pinId: NSManagedObjectID, image: UIImage) {
        DataController.shared.backgroundContext.perform {
            let currentPin = DataController.shared.backgroundContext.object(with: pinId) as! Pin
            //create image
            let photo = Photo(context: DataController.shared.backgroundContext)
            photo.image = image.jpegData(compressionQuality: 1)
            photo.pin = currentPin
            photo.creationDate = Date()
            // save to dataCore
            do{
                // save to context
                try DataController.shared.backgroundContext.save()
                 print("imaged saved")
            } catch (let error){
                print(error)
            }
           
        }
        
    }
    
    // Mark: isThereImages
    func isThereImages(pin: Pin) -> Bool {
        // create fetch request
        let photoRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
        photoRequest.predicate = NSPredicate(format: "pin == %@", pin)
        if let result = try? DataController.shared.viewContext.fetch(photoRequest){
            if(!result.isEmpty){
                return true
            }
        }
        return false
    }
    
    // Mark: downloadList
    func downloadList(list: Photos, pin: Pin) {
        let downloadQueue = DispatchQueue(label: "download")
        downloadQueue.async{
            let photoList = list.photo
            // start download loop
            for photo in photoList! {
                // check for url
                guard let imgUrl = photo.url_m else{
                    continue
                }
                guard let url = URL(string: imgUrl) else{
                    continue
                }
                // download image using kingfisher
                imageManager.sharedInstance().downloadImage(url: url, completion: { (image, success) in
                    if(success){
                        let pinId = pin.objectID
                        self.SaveImageForPin(pinId: pinId, image: image!)
                    }
                })
            }
        }
    }
    
}
