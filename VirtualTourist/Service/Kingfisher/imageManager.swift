//
//  imageManager.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 19/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
import Kingfisher

class imageManager {
    // downloader
    let downloader = ImageDownloader.default
    //shared instance
    class func sharedInstance() -> imageManager{
        struct Singleton {
            static var sharedInstance = imageManager()
        }
        return Singleton.sharedInstance
    }
}

extension imageManager {
    // Mark: downloadImage
    func downloadImage (url: URL, completion: @escaping (UIImage?, Bool)->())  {
        let dispatchQueue = DispatchQueue(label: "download")
        dispatchQueue.async {
            self.downloader.downloadImage(with: url ) { result in
                switch result {
                case .success(let value):
                    completion(value.image, true)
                    break
                case .failure(let error):
                    print(error)
                    completion(nil, false)
                }
            }
        }
        
    }
}
