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
        let socialUrl = URL(string: socials[indexPath.row].socialUrl)!
        if UIApplication.shared.canOpenURL(socialUrl){
            UIApplication.shared.open(socialUrl)
        } else {
            print("Can't open social url \(socials[indexPath.row].socialUrl)")
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
        let cell = socialTableView.dequeueReusableCell(withIdentifier: "socialCell", for: indexPath)
        
        let url = URL(string: socials[indexPath.row].imgUrl)
        cell.imageView?.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        cell.textLabel?.text = socials[indexPath.row].socialCellText
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
