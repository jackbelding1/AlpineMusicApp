//
//  SettingsCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit

extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: settings[indexPath.row].replacingOccurrences(of: " ", with: ""), bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        self.present(vc, animated: true, completion: nil)
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        return cell
    }
}
