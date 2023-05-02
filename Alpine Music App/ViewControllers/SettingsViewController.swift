//
//  SettingsVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var settingsView: UITableView!
    let settings:[String] = ["Support Me"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
        settingsView.dataSource = self
    }
}

