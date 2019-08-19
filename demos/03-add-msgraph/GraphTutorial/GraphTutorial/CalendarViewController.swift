//
//  CalendarViewController.swift
//  GraphTutorial
//
//  Created by Jason Johnston on 8/16/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
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
