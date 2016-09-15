//
//  Networking.swift
//  WidgetDemo
//
//  Created by Hesham Abd-Elmegid on 6/27/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import Foundation

class Networking: NSObject {
    enum QuoteType: String {
        case Movies = "movies"
        case FamousPeople = "famous"
    }
    
    typealias CompletionHandler = (quote: Quote?, error: NSError?) -> ()
    
    func randomMoviesQuote(type: QuoteType, completion: CompletionHandler) {
        let urlString = "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=\(type.rawValue)"
        let apiURL = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: apiURL!)
        request.HTTPMethod = "POST"
        request.addValue("70kHu82V9Jmshv3cD2gNkUF915jsp1K0HlYjsnVcns7jvOI4O1", forHTTPHeaderField: "X-Mashape-Key")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard let data = data where error == nil else {
                print(error)
                return
            }
            
            do {
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:String]
                let quote = Quote(quoteDictionary: jsonResponse)
                completion(quote: quote, error: nil)
            } catch {
                print("JSON error: \(error)")
            }
        }
        
        task.resume()
        
        
    }
}
