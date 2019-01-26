//
//  FlickrAPI.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 09/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: Flickr API
class FlickrAPI {
    // shared session
    var sharedSession = URLSession.shared
    //set base URL for API
    let hostURL = "api.flickr.com"
    let scheme = "https"
    let urlPath = "/services/rest/"
    //set Flickr sectret
    let secret = "a2bfba323c701470"
    // set url parameters
    var flickrUrl = [
        "method": "flickr.photos.search",
        "api_key": "e5c736479658a5fa2e9bc1800742bc92",
        "accuracy": 11,
        "per_page": 21,
        "format": "json",
        "nojsoncallback": 1,
        "radius": 10,
        "extras" : "url_m"
    ] as [String: AnyObject]
    //shared instance
    class func sharedInstance() -> FlickrAPI{
        struct Singleton {
            static var sharedInstance = FlickrAPI()
        }
        return Singleton.sharedInstance
    }
    //dispatchQueue
    let dispatchQueue = DispatchQueue(label: "flickr")
}
