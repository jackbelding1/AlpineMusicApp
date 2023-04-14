//
//  CurrentStreamCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import AVFoundation

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerItem = AVPlayerItem(url: URL(string: streams[indexPath.row].url)!)
        player.replaceCurrentItem(with: playerItem)
        present(PlayerController, animated: true) {

            self.player.play()
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = streamView.dequeueReusableCell(withIdentifier: "currentStreamCell", for: indexPath)
        cell.imageView?.image = UIImage(named: "logo.jpg")
        cell.textLabel?.text = streams[indexPath.row].title
        return cell
    }
    
}
