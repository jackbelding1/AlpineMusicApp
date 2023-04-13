//
//  HomeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var streamView: UITableView!
    
    public let test = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        streamView.delegate = self
        streamView.dataSource = self
    }


}
