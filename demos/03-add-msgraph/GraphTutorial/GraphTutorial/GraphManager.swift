//
//  GraphManager.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSGraphClientSDK
import MSGraphClientModels

class GraphManager {

    // Implement singleton pattern
    static let instance = GraphManager()

    private let client: MSHTTPClient?

    private init() {
        client = MSClientFactory.createHTTPClient(with: AuthenticationManager.instance)
    }

    public func getMe(completion: @escaping(MSGraphUser?, Error?) -> Void) {
        // GET /me
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me")!)
        let meDataTask = MSURLSessionDataTask(request: meRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let meData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }

            do {
                // Deserialize response as a user
                let user = try MSGraphUser(data: meData)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        })

        // Execute the request
        meDataTask?.execute()
    }
    
    public func getEvents(completion: @escaping([MSGraphEvent]?, Error?) -> Void) {
        // GET /me/events?$select='subject,organizer,start,end'$orderby=createdDateTime DESC
        // Only return these fields in results
        let select = "$select=subject,organizer,start,end"
        // Sort results by when they were created, newest first
        let orderBy = "$orderby=createdDateTime+DESC"
        let eventsRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/events?\(select)&\(orderBy)")!)
        let eventsDataTask = MSURLSessionDataTask(request: eventsRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let eventsData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            do {
                // Deserialize response as events collection
                let eventsCollection = try MSCollection(data: eventsData)
                var eventArray: [MSGraphEvent] = []
                
                eventsCollection.value.forEach({
                    (rawEvent: Any) in
                    // Convert JSON to a dictionary
                    guard let eventDict = rawEvent as? [String: Any] else {
                        return
                    }
                    
                    // Deserialize event from the dictionary
                    let event = MSGraphEvent(dictionary: eventDict)!
                    eventArray.append(event)
                })
                
                // Return the array
                completion(eventArray, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        // Execute the request
        eventsDataTask?.execute()
    }
}
