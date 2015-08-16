//
//  RestApiManager.swift
//  Baseball
//
//  Created by Brian Cox on 8/15/15.
//  Copyright © 2015 Brian Cox. All rights reserved.
//

import Foundation

typealias serviceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://10.0.0.3:8080/raspberry/pi/state"
    var dictionary: [String:Int] = [
        "id" : 1,
        "score1" : 9,
        "score2" : 7
    ]
    
    
    
    func getState(onCompletion: (JSON) -> Void) {
        makeHTTPGETRequest(baseURL, onCompletion: {json, err -> Void in
            onCompletion(json)
        })
    }
    
    func postState(onCompletion: (JSON) -> Void) {
        makeHTTPPostRequest(baseURL, params: dictionary, onCompletion: {json, err -> Void in
            onCompletion(json)
        })
    }
    
    func makeHTTPPostRequest(path: String, params : Dictionary<String, Int>, onCompletion: serviceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
            request.HTTPBody = nil
        }
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    print("Success: \(success)")
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        
        task.resume()
    }
        
    func makeHTTPGETRequest(path: String, onCompletion: serviceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        print(json)
        })
        task.resume()
    }
    
}