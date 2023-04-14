//
//  HomeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import AVKit


class HomeVC: UIViewController {
    
    @IBOutlet var streamView: UITableView!
    
    let streams:[Stream] = [Stream.testStream] // TODO: populate this list from firebase
    let player = AVPlayer()
    let PlayerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        streamView.delegate = self
        streamView.dataSource = self
        PlayerController.player = player
    }
}
