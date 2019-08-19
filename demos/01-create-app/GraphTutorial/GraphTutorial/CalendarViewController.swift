//
//  CalendarViewController.swift
//  GraphTutorial
//
//  Copyright © 2019 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet var calendarJSON: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // TEMPORARY
        calendarJSON.text = "Calendar"
        calendarJSON.sizeToFit()
    }
}
