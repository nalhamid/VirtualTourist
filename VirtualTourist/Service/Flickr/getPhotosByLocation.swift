//
//  getPhotosByLocation.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 12/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
import Alamofire

extension FlickrAPI {
    // Mark: get photos by locations
    func getPhotosByLocation(lat: Double, long: Double, completion: @escaping (Photos, Bool, String)->()){
        dispatchQueue.async {
            var flickrPhotos = Photos()
            // set url with parameters
            var paramUrl = self.getFlickrUrl(lat: lat, long: long, pageNum: nil)
            // get number of pages
            self.getTotalPages(requestUrl: paramUrl) { (numberOfPages, success, message) in
                // check if get total pages success
                if(!success){
                    //return if failed
                    completion(flickrPhotos, success, message)
                }
                //set Url Request properaties
                paramUrl = self.getFlickrUrl(lat: lat, long: long, pageNum: numberOfPages)
                // send url request
                let request = URLRequest(url: paramUrl)
                // make request with Alamofire
                Alamofire.request(request).validate().responseObject(completionHandler: { (response: DataResponse<Flickr>) in
                    // default values
                    
                    var errorMessage : String = ""
                    var success = false
                    
                    // switch based on success
                    switch response.result {
                    // if successed
                    case .success :
                        // validate data
                        if let resultPhotos = response.value {
                            // get images
                                flickrPhotos = resultPhotos.photos
                                success = true
                            } else {
                                errorMessage = "There was an error with your request"
                            }
                        break
                    // if failed
                    case .failure(let error):
                        errorMessage = "There was an error with your request: \(error)"
                        break
                    }
                    // return results
                    completion(flickrPhotos, success, errorMessage)
                })
                
            }
        }
    }
}
