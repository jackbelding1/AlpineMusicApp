//
//  CustomTabBarController.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    // open to homescreen
    @IBInspectable var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create banner (deprecated)
//        let image = UIImage(named: "logo-removebg.png")
//        let frameWid = (view.frame.width / 3) - 60
//        let imageView = UIImageView(frame: CGRect(x: (view.frame.width / 2) - (frameWid / 2), y:0,
//                                                width: frameWid,
//                                                height:((navigationController?.navigationBar.frame.height)!)))
////        imageView.image = image
//        navigationController?.navigationBar.addSubview(imageView)
//        navigationController?.navigationBar.backgroundColor = UIColor.clear
        selectedIndex = initialIndex
    }
}
