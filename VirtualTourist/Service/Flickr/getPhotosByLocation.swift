//
//  getPhotosByLocation.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 12/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
extension FlickrAPI {
    // Mark: get photos by locations
    func getPhotosByLocation(lat: Double, long: Double, completion: @escaping (Photos, Bool, String)->()){
        dispatchQueue.async {
            // set url with parameters
            var paramUrl = self.getFlickrUrl(lat: lat, long: long, pageNum: nil)
            // get number of pages
            self.getTotalPages(requestUrl: paramUrl) { (numberOfPages, success, message) in
                var flickrPhotos = Photos()
                // check if get total pages success
                if(!success){
                    //return if failed
                    completion(flickrPhotos, success, message)
                }
                //set Url Request properaties
                paramUrl = self.getFlickrUrl(lat: lat, long: long, pageNum: numberOfPages)
                // send url request
                let request = URLRequest(url: paramUrl)
                let task = self.sharedSession.dataTask(with: request ) { ( data, response, error)  in
                    DispatchQueue.main.async {
                        var errorMessage : String = ""
                        //  check if the request have an error
                        guard (error == nil) else {
                            errorMessage = "There was an error with your request: \(error!)"
                            completion(flickrPhotos, false, errorMessage)
                            return
                        }
                        // check if the response successful (2XX response)
                        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                            let code = (response as? HTTPURLResponse)?.statusCode
                            errorMessage = "Your request was not successful. code: \(code!)"
                            completion(flickrPhotos, false, errorMessage)
                            return
                        }
                        // check if there any data returned
                        guard let data = data else {
                            errorMessage = "No data was returned by the request!"
                            completion(flickrPhotos, false, errorMessage)
                            return
                        }
                        // parse data
                        do {
                            // parse resulting data
                            let flickr  = try JSONDecoder().decode(Flickr.self, from: data)
                            flickrPhotos = flickr.photos
                            
                        } catch let jsonErr {
                            errorMessage = "Failed to decode data. error: \(jsonErr)"
                            completion(flickrPhotos, false, errorMessage)
                        }
                        // return results
                        completion(flickrPhotos, true, errorMessage)
                    }
                }
                task.resume()
            }
        }
    }
}
