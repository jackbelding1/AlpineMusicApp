//
//  AboutVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "logo.jpg")
    }


}

