//
//  getTotalPages.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 12/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
extension FlickrAPI {
    // Mark: get number of pages to randomaize
    func getTotalPages(requestUrl: URL, completion: @escaping (Int, Bool, String)->()){
        dispatchQueue.async{
            // send url request
            let request = URLRequest(url: requestUrl)
            let task = self.sharedSession.dataTask(with: request ) { ( data, response, error)  in
                DispatchQueue.main.async {
                    var pageNum = 0
                    var errorMessage : String = ""
                    //  check if the request have an error
                    guard (error == nil) else {
                        errorMessage = "There was an error with your request: \(error!)"
                        completion(pageNum, false, errorMessage)
                        return
                    }
                    // check if the response successful (2XX response)
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                        let code = (response as? HTTPURLResponse)?.statusCode
                        errorMessage = "Your request was not successful. code: \(code!)"
                        completion(pageNum, false, errorMessage)
                        return
                    }
                    // check if there any data returned
                    guard let data = data else {
                        errorMessage = "No data was returned by the request!"
                        completion(pageNum, false, errorMessage)
                        return
                    }
                    // parse data
                    do {
                        // parse resulting data
                        let resultPhotos  = try JSONDecoder().decode(Flickr.self, from: data)
                        if(resultPhotos.photos.pages != 0){
                            pageNum = Int(arc4random_uniform(UInt32(resultPhotos.photos.pages! - 1))) + 1
                        } else {
                            errorMessage = "There are No images around the area"
                            completion(pageNum, false, errorMessage)
                        }
                    } catch let jsonErr {
                        errorMessage = "Failed to decode data. error: \(jsonErr)"
                        completion(pageNum, false, errorMessage)
                    }
                    // return results
                    completion(pageNum, true, errorMessage)
                }
            }
            task.resume()
        }
        
    }
}
