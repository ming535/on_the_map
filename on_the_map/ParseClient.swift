//
//  ParseClient.swift
//  on_the_map
//
//  Created by Ming Hu on 6/19/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import Foundation

struct ParseClient {
    static func getStudentLocations(completionHandler: ((results: [[String: AnyObject]]) -> Void)?) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            
            if let resultsString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData((resultsString.dataUsingEncoding(NSUTF8StringEncoding))!, options: .AllowFragments)
                    if let results = json["results"] as? [[String: AnyObject]] {
                        dispatch_async(dispatch_get_main_queue()) {
                            if let completionHandler = completionHandler {
                                completionHandler(results: results)
                            }
                        }
                    }
                
                } catch {
                    print(error)
                }
                
                
                
            }
        }
        task.resume()
    }
}