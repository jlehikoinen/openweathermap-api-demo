//
//  HTTPMethods.swift
//  OpenWeatherMap API Demo
//
//  Created by Janne Lehikoinen on 08/03/2019.
//  Copyright © 2019 Janne Lehikoinen. All rights reserved.
//

import Cocoa

struct HTTPMethods {
    
    typealias dataFromURLCompletionClosure = (Data?, URLResponse?, Error?) -> Void
    
    func getRequest(_ targetUrl: String, handler: @escaping dataFromURLCompletionClosure) {
        
        // Configure the request
        var request = URLRequest(url: URL(string: targetUrl)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Make the request asynchronously
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            // Return data, response & error
            handler(data, response, error)
        })
        task.resume()
    }
}
