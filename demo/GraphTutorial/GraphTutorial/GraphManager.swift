//
//  GraphManager.swift
//  GraphTutorial
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license.
//

import Foundation
import MSGraphClientSDK
import MSGraphClientModels

class GraphManager {

    // Implement singleton pattern
    static let instance = GraphManager()

    private let client: MSHTTPClient?
    
    public var userTimeZone: String

    private init() {
        client = MSClientFactory.createHTTPClient(with: AuthenticationManager.instance)
        userTimeZone = "UTC"
    }

    public func getMe(completion: @escaping(MSGraphUser?, Error?) -> Void) {
        // GET /me
        let select = "$select=displayName,mail,mailboxSettings,userPrincipalName"
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me?\(select)")!)
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
    
    // <GetEventsSnippet>
    public func getCalendarView(viewStart: String,
                                viewEnd: String,
                                completion: @escaping([MSGraphEvent]?, Error?) -> Void) {
        // GET /me/calendarview
        // Set start and end of the view
        let start = "startDateTime=\(viewStart)"
        let end = "endDateTime=\(viewEnd)"
        // Only return these fields in results
        let select = "$select=subject,organizer,start,end"
        // Sort results by when they were created, newest first
        let orderBy = "$orderby=start/dateTime"
        // Request at most 25 results
        let top = "$top=25"
        
        let eventsRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/calendarview?\(start)&\(end)&\(select)&\(orderBy)&\(top)")!)
        
        // Add the Prefer: outlook.timezone header to get start and end times
        // in user's time zone
        eventsRequest.addValue("outlook.timezone=\"\(self.userTimeZone)\"", forHTTPHeaderField: "Prefer")

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
    // </GetEventsSnippet>
    
    // <CreateEventSnippet>
    public func createEvent(subject: String,
                            start: Date,
                            end: Date,
                            attendees: [Substring]?,
                            body: String?,
                            completion: @escaping(MSGraphEvent?, Error?) -> Void) {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        // Create a dictionary to represent the event
        // Current version of the Graph SDK models don't serialize properly
        // see https://github.com/microsoftgraph/msgraph-sdk-objc-models/issues/27
        var newEventDict: [String: Any] = [
            "subject": subject,
            "start": [
                "dateTime": isoFormatter.string(from: start),
                "timeZone": self.userTimeZone
            ],
            "end": [
                "dateTime": isoFormatter.string(from: end),
                "timeZone": self.userTimeZone
            ]
        ]
        
        if attendees?.count ?? 0 > 0 {
            var attendeeArray: [Any] = []
            
            for attendee in attendees! {
                let attendeeDict: [String: Any] = [
                    "type": "required",
                    "emailAddress": [
                        "address": String(attendee)
                    ]
                ]
                
                attendeeArray.append(attendeeDict)
            }
            
            newEventDict["attendees"] = attendeeArray
        }
        
        if !(body?.isEmpty ?? false) {
            newEventDict["body"] = [
                "content": body,
                "contentType": "text"
            ]
        }
        
        let eventData = try? JSONSerialization.data(withJSONObject: newEventDict)
        
        let createEventRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/events")!)
        createEventRequest.httpMethod = "POST"
        createEventRequest.httpBody = eventData
        createEventRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let createEventTask = MSURLSessionDataTask(request: createEventRequest, client: self.client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let eventData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            do {
                // Deserialize response as event
                let returnedEvent = try MSGraphEvent(data: eventData)

                // Return the event
                completion(returnedEvent, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        // Execute the task
        createEventTask?.execute()
    }
    // </CreateEventSnippet>
}
