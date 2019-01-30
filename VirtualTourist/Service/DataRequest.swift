//
//  DataRequest.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 30/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//  source: https://medium.com/@mhacnagbani/alamofire-generic-response-object-serialization-using-codable-13db342347b2

import UIKit
import Alamofire

// @Returns - DataRequest
// completionHandler handles JSON Object T
extension DataRequest{
    
    enum BackendError: Error {
        case network(error: Error) // Capture any underlying Error from the URLSession API
        case dataSerialization(error: Error)
        case jsonSerialization(error: Error)
        case xmlSerialization(error: Error)
        case objectSerialization(reason: String)
    }
    
    @discardableResult func responseObject<T: Decodable> (queue: DispatchQueue? = nil , completionHandler: @escaping (DataResponse<T>) -> Void ) -> Self{
            
            let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
                guard error == nil else {return .failure(BackendError.network(error: error!))}
                
                let result = DataRequest.serializeResponseData(response: response, data: data, error: error)
                guard case let .success(jsonData) = result else{
                    return .failure(BackendError.jsonSerialization(error: result.error!))
                }
                
                // (1)- Json Decoder. Decodes the data object into expected type T
                // throws error when failes
                let decoder = JSONDecoder()
                guard let responseObject = try? decoder.decode(T.self, from: jsonData)else{
                    return .failure(BackendError.objectSerialization(reason: "JSON object could not be serialized \(String(data: jsonData, encoding: .utf8)!)"))
                }
                return .success(responseObject)
            }
            return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    /// @Returns - DataRequest
    /// completionHandler handles JSON Array [T]
    @discardableResult func responseCollection<T: Decodable>(
        queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void
        ) -> Self{
        
        let responseSerializer = DataResponseSerializer<[T]>{ request, response, data, error in
            guard error == nil else {return .failure(BackendError.network(error: error!))}
            
            let result = DataRequest.serializeResponseData(response: response, data: data, error: error)
            guard case let .success(jsonData) = result else{
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            let decoder = JSONDecoder()
            guard let responseArray = try? decoder.decode([T].self, from: jsonData)else{
                return .failure(BackendError.objectSerialization(reason: "JSON array could not be serialized \(String(data: jsonData, encoding: .utf8)!)"))
            }
            
            return .success(responseArray)
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
