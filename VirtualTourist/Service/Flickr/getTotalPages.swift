//
//  getTotalPages.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 12/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
import Alamofire

extension FlickrAPI {
    // Mark: get number of pages to randomaize
    func getTotalPages(requestUrl: URL, completion: @escaping (Int, Bool, String)->()){
        dispatchQueue.async{
            // send url request
            let request = URLRequest(url: requestUrl)
            // make request with Alamofire
            Alamofire.request(request).validate().responseObject(completionHandler: { (response: DataResponse<Flickr>) in
                // default values
                var pageNum = 0
                var errorMessage : String = ""
                var success = false
                
                // switch based on success
                switch response.result {
                // if successed
                case .success :
                    // validate data
                    if let resultPhotos = response.value {
                        // check number of pages
                        if(resultPhotos.photos.pages != 0){
                            // generate random page number
                            pageNum = Int(arc4random_uniform(UInt32(resultPhotos.photos.pages! - 1))) + 1
                            success = true
                        } else {
                            errorMessage = "There are No images around the area"
                        }
                    }
                    break
                // if failed
                case .failure(let error):
                    errorMessage = "There was an error with your request: \(error)"
                    break
                }
                // return results
                completion(pageNum, success, errorMessage)
            })
        }
        
    }
}
