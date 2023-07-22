//
//  SettingsVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import WebKit

class SettingsViewController: UIViewController, WKUIDelegate {

    // the table of app settings/more
    @IBOutlet weak var settingsAndMore: UITableView!
    // the setting cells to be displayed
    let settings:[String] = ["Support Me", "Privacy Policy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsAndMore.delegate = self
        settingsAndMore.dataSource = self
        settingsAndMore.accessibilityIdentifier = "settingsTable"
    }
}

