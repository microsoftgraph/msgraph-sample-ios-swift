//
//  NewEventViewController.swift
//  GraphTutorial
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license.
//

// <NewEventViewControllerSnippet>
import UIKit
import MSGraphClientModels

class NewEventViewController: UIViewController {
    @IBOutlet var subject: UITextField!
    @IBOutlet var attendees: UITextField!
    @IBOutlet var start: UIDatePicker!
    @IBOutlet var end: UIDatePicker!
    @IBOutlet var body: UITextView!

    private let spinner = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add border around text view
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        body.layer.borderWidth = 0.5
        body.layer.borderColor = borderColor.cgColor
        body.layer.cornerRadius = 5.0

        // Set start picker to the next closest half-hour
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from:now)
        let offset = 30 - (components.minute! % 30)

        let start = calendar.date(byAdding: .minute, value: offset, to: now)
        self.start.date = start!

        // Set end picker to start + 30 min
        let end = calendar.date(byAdding: .minute, value: 30, to: start!)
        self.end.date = end!
    }

    @IBAction func createEvent() {
        self.spinner.start(container: self)

        // Do create

        let subject = self.subject.text ?? ""
        let attendees = self.attendees.text?.split(separator: ";")

        let start = self.start.date
        let end = self.end.date

        let body = self.body.text ?? ""

        GraphManager.instance.createEvent(subject: subject,
                                          start: start,
                                          end: end,
                                          attendees: attendees,
                                          body: body) {
            (event: MSGraphEvent?, error: Error?) in
            DispatchQueue.main.async {
                self.spinner.stop()
                guard let _ = event, error == nil else {
                    // Show the error
                    let alert = UIAlertController(title: "Error creating event",
                                                  message: error.debugDescription,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }

                let alert = UIAlertController(title: "Success",
                                              message: "Event created",
                                              preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (action: UIAlertAction?) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
            }
        }
    }

    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
// </NewEventViewControllerSnippet>
