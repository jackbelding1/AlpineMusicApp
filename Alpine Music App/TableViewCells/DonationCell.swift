//
//  DonationCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/25/23.
//

import UIKit

extension SupportMeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // donate selected amount
        storeRepository.donate(option: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SupportMeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = donationsView.dequeueReusableCell(withIdentifier: "donationCell", for: indexPath)
        cell.textLabel?.text = cellLabels[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
