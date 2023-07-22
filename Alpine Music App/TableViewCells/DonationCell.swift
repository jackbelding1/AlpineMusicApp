//
//  DonationCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/25/23.
//

import UIKit

extension SupportMeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // donate selected amount
        storeRepository.donate(option: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SupportMeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationOptionLabels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = donationOptions.dequeueReusableCell(withIdentifier: "donationCell", for: indexPath)
        cell.textLabel?.text = donationOptionLabels[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
