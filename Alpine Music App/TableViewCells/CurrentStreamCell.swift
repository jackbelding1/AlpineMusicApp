//
//  CurrentStreamCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath[1])
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = streamView.dequeueReusableCell(withIdentifier: "currentStreamCell", for: indexPath)
        cell.imageView?.image = UIImage(named: "logo.jpg")
        cell.textLabel?.text = "Hello world"
        return cell
    }
    
}
