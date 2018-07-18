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
        static let contentType = "application/json"
    }
    
    
    var quote: Quote!
    var image: Image!
    
    func getQuote(_ completion: @escaping (Quote) -> Void) {
        let sessionCofig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionCofig)
        let url = URL(string: "http://api.forismatic.com")!
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
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,Any?> else { return }
            let newQuote = Quote(quote: jsonResult!["quoteText"] as! String, author: jsonResult!["quoteAuthor"] as? String) 
            self.quote = newQuote
            completion(self.quote)
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
    
    func getImages(_ completion: @escaping(Image) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let url = URL(string: "https://api.imgur.com/3/gallery/random/random/0")!
        var request = URLRequest(url: url)
        request.addValue(headerConstants.authorization, forHTTPHeaderField: "Authorization")
        request.addValue(headerConstants.contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task success: \(statusCode)")
            } else if let error = error {
                print("URL session failed with error: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            guard let jsonResult = try! JSONSerialization.jsonObject(with: data) as?
                Dictionary<String,Any?>, let dataJSON = jsonResult["data"] as? Array<Dictionary<String,Any?>> else {
                    print(#line, "json is botched")
                    return
                    
                    
            }
            
            let count = dataJSON.count
            let rand = arc4random_uniform(UInt32(count) - UInt32(1))
            let image = dataJSON[Int(rand)]
            
            guard let link = image["link"] as? String else {
                print(#line, "no link")
                return
            }
            
            let newImage = Image(link: link)
            self.image = newImage
            completion(self.image)
//            let jsonArray : [Dictionary] = jsonResult["data"]!
//            for jsonData in jsonArray {
//                guard let link = jsonData["link"] as? String else { return }
//               let newImage = Image(link: link)
//                self.image = newImage
//                completion(self.image)
//            }
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    
    
    
    
    
    
}


