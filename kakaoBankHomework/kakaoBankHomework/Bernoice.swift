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
    
    lazy var session : URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: config)
    }()
    
    static let shared = Bernoice()
    
    private init() {
        
    }
    
    func getByRemote(url: String, completion :@escaping (Data) -> Void ) -> URLSessionDataTask? { 
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
