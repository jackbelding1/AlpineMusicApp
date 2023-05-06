//
//  SettingsCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit

extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = settings[indexPath.row]
        switch cell {
            case "Support Me":
                let storyboard = UIStoryboard(name: cell.replacingOccurrences(of: " ", with: ""), bundle: nil)
                let vc = storyboard.instantiateInitialViewController()!
                self.present(vc, animated: true, completion: nil)
            case "Privacy Policy":
                let myURL = URL(string:"https://www.alpinemusic.app/privacy/")
                let vc = PrivacyWebViewViewController(url: myURL!, title: "Privacy Policy")
                let navVC = UINavigationController(rootViewController: vc)
                present(navVC, animated: true)
            case "Notifications":
                print("notifications")
                break
            default:
                break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
}
