//
//  CurrentStreamCell.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import Kingfisher
import AVFoundation

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // play the stream for the selected cell
        AVPlayerManager.shared.playStream(withURL:
                                            URL(string: streams[indexPath.row].url)!,
                                            self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = streamView.dequeueReusableCell(withIdentifier: "currentStreamCell", for: indexPath)
        let url = URL(string: streams[indexPath.row].thumbnailUrl)
        cell.imageView?.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        cell.textLabel?.text = streams[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
}
