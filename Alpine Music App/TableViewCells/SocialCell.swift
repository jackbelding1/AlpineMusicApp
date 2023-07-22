//
//  SocialCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/19/23.
//

import UIKit
import Kingfisher

extension AboutVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get url link
        let socialURL = URL(string: socials[indexPath.row].profileURL)!
        
        // open social media URL
        if UIApplication.shared.canOpenURL(socialURL) {
            UIApplication.shared.open(socialURL)
        } else {
            print("Can't open social url \(socials[indexPath.row].profileURL)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AboutVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = socialTableView.dequeueReusableCell(
            withIdentifier: "socialCell",
            for: indexPath
        )
        let imageURL = URL(string: socials[indexPath.row].imageURL)
        cell.imageView?.kf.setImage(with: imageURL) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        cell.textLabel?.text = socials[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
