//
//  Bernoice.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 11..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import Foundation
import SwiftyJSON


open class Bernoice {
    
    lazy var sessionWithCache : URLSession = {
        let config = URLSessionConfiguration.default
        let imageCache = URLCache(memoryCapacity: 250*1024*1024, diskCapacity: 250*1024*1024, diskPath: "imageCache")
        
        config.urlCache = imageCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()
    
    
    lazy var sessionWithoutCache : URLSession = {
        let config = URLSessionConfiguration.default
        let cache = URLCache(memoryCapacity: 250*1024*1024, diskCapacity: 250*1024*1024, diskPath: "dataCache")
        config.urlCache = cache
        config.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: config)
    }()
    
    static let shared = Bernoice()
    
    private init() {
    }
    
    func getByRemote(url: String, cached : Bool, completion :@escaping (Data) -> Void ) -> URLSessionDataTask? { 
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let cacheFlag = true
        let session = cacheFlag ? sessionWithCache : sessionWithoutCache
        
        let task : URLSessionDataTask =  session.dataTask(with: request , completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print("network error : \(error!)")
                return
            }
            
            if let dataUnwrapped = data {
                completion(dataUnwrapped)
            }
            
        })
        task.resume()
        return task
    }
    
    
}
