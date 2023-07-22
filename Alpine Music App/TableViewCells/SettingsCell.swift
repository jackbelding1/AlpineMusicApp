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
            // initialize support me view controller
            let supportMeViewController = UIStoryboard(
                name: cell.replacingOccurrences(of: " ", with: ""),
                bundle: nil
            ).instantiateInitialViewController()!
            
            // present user with support me pop over
            present(supportMeViewController, animated: true, completion: nil)
            
        case "Privacy Policy":
            // initialize privacy policy web view controller
            let privacyPolicyWebViewController = UINavigationController(
                rootViewController: PrivacyWebViewViewController(
                    url: URL(string:"https://www.alpinemusic.app/privacy/")!,
                    title: "Privacy Policy"
                )
            )
            
            // present privacy policy page in web view
            present(privacyPolicyWebViewController, animated: true)
            
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
