//
//  Photos.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 09/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation

struct Flickr : Codable {
    var photos : Photos
}

// Mark: flickr photos struct
struct Photos : Codable {
    var page : Int?
    var pages : Int?
    var perpage : Int?
    var photo : [FlickrPhoto]?
    var stat : String?
}

// Mark: flickr photo struct
struct FlickrPhoto : Codable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let url_m: String?
}
