//
//  CustomTabBarController.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    @IBInspectable var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "logo.jpg")
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:(view.frame.width) / 3 , height:((navigationController?.navigationBar.frame.height)!)))
        imageView.image = image
        navigationController?.navigationBar.addSubview(imageView)
        navigationController?.navigationBar.backgroundColor = UIColor.black
        selectedIndex = initialIndex
    }
}
