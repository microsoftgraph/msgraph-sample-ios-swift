//
//  CalendarViewController.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSGraphClientModels

class CalendarViewController: UIViewController {

    @IBOutlet var calendarJSON: UITextView!
    
    private let spinner = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.spinner.start(container: self)
        
        GraphManager.instance.getEvents {
            (data: Data?, error: Error?) in
            DispatchQueue.main.async {
                self.spinner.stop()
                
                guard let eventsData = data, error == nil else {
                    self.calendarJSON.text = error.debugDescription
                    return
                }
                
                let jsonString = String(data: eventsData, encoding: .utf8)
                self.calendarJSON.text = jsonString
                self.calendarJSON.sizeToFit()
            }
        }
    }
}
