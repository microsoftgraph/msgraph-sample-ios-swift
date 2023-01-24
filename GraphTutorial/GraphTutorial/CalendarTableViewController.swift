//
//  CalendarTableViewController.swift
//  GraphTutorial
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license.
//

// <CalendarTableViewControllerSnippet>
import UIKit
import MSGraphClientModels

class CalendarTableViewController: UITableViewController {
    private let tableCellIdentifier = "EventCell"
    private var events: [MSGraphEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    // Number of sections, always 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Return the number of events in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! CalendarTableViewCell

        // Get the event that corresponds to the row
        let event = events?[indexPath.row]

        // Configure the cell
        cell.subject = event?.subject
        cell.organizer = event?.organizer?.emailAddress?.name

        // Build a duration string
        let duration = "\(self.formatGraphDateTime(dateTime: event?.start)) to \(self.formatGraphDateTime(dateTime: event?.end))"
        cell.duration = duration

        return cell
    }

    private func formatGraphDateTime(dateTime: MSGraphDateTimeTimeZone?) -> String {
        guard let graphDateTime = dateTime else {
            return ""
        }
        // Create a formatter to parse Graph's date format
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

        let date = isoFormatter.date(from: graphDateTime.dateTime)

        // Output like 5/5/2019, 2:00 PM
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date!)
    }
    
    public func setEvents(events: [MSGraphEvent]?) -> Void {
        self.events = events
        self.tableView.reloadData()
    }
}
// </CalendarTableViewControllerSnippet>
