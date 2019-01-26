//
//  getFlickrUrl.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 12/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation

extension FlickrAPI {
    // Mark: getFlickrUrl
    func getFlickrUrl (lat: Double, long: Double, pageNum: Int?) -> URL {
        var fullParam = flickrUrl
        fullParam["lat"] =  lat as AnyObject
        fullParam["lon"] =  long as AnyObject
        // check if number of pages is set
        if let pageNum = pageNum {
            fullParam["page"] =  pageNum as AnyObject
        }
        //set URL components
        var components = URLComponents()
        components.scheme = scheme
        components.host = hostURL
        components.path = urlPath
        components.queryItems = [URLQueryItem]()
        // loop to set params
        for(key, value) in fullParam {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        // return full url
        return components.url!
    }
}
