//
//  SettingsVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import WebKit

class SettingsVC: UIViewController, WKUIDelegate {

    @IBOutlet weak var settingsView: UITableView!
    let settings:[String] = ["Support Me", "Notifications", "Privacy Policy"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
        settingsView.dataSource = self
    }
}

