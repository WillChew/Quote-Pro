//
//  RequestManager.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class RequestManager {
    
    enum QueryParameters {
        static let method = "getQuote"
        static let lang = "en"
        static let format = "json"
    }
    
    enum headerConstants {
        static let authorization = "Client-ID 887c27b7d390539"
    }
    
    
    var quote: Quote!
    
    func getQuote(_ completion: @escaping (Quote) -> Void) {
        let sessionCofig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionCofig)
        let url = URL(string: "https://api.forismatic.com")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path = "/api/1.0/"
        
        let methodQueryItem = NSURLQueryItem(name: "method", value: QueryParameters.method)
        let langQueryItem = NSURLQueryItem(name: "lang", value: QueryParameters.lang)
        let formatQueryItem = NSURLQueryItem(name: "format", value: QueryParameters.format)
        
        components.queryItems = [methodQueryItem, langQueryItem, formatQueryItem] as [URLQueryItem]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task success: \(statusCode)")
            } else if let error = error {
                //fail
                print("URL session task failed with error: \(error.localizedDescription)")
            }
            guard let data = data else {return}
            guard let jsonResult = try! JSONSerialization.jsonObject(with: data) as? Dictionary<String,Any?> else { return }
            let newQuote = Quote(quote: jsonResult["quoteText"] as! String, author: jsonResult["quoteAuthor"] as? String)
            self.quote = newQuote
            completion(self.quote)
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
    
    
    
    
    
    
    
    
}


