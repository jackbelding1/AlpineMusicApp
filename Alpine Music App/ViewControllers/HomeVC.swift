//
//  HomeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import AVKit

class HomeVC: UIViewController {
    
    @IBOutlet var streamView: UITableView!
    @IBOutlet weak var currentStreamView: UIImageView!
    @IBOutlet weak var divider: UILabel!
    
    @Published var streams = [Stream]()
    let player = AVPlayer()
    let PlayerController = AVPlayerViewController()
    private let streamsRepository: StreamsRepositoryProtocol = StreamsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(streamViewTapped(tapGestureRecognizer:)))
        currentStreamView.isUserInteractionEnabled = true
        currentStreamView.addGestureRecognizer(tapGestureRecognizer)
        
        fetchStreams()
        
        streamView.delegate = self
        streamView.dataSource = self
        
        PlayerController.player = player
    }
    
    @objc func streamViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // open stream view with stream channel playback url
        let playerItem = AVPlayerItem(url: URL(string: "https://c1c3ba7f553a.us-east-1.playback.live-video.net/api/video/v1/us-east-1.080740216434.channel.a1p4kxOjkwVx.m3u8")!)
        player.replaceCurrentItem(with: playerItem)
        present(PlayerController, animated: true) {
            
            self.player.play()
        }
    }
    
    func fetchStreams() {
        Task {
            do {
                streams = try await streamsRepository.fetchStreams()
                streamView.reloadData()
            } catch {
                print("Cannoth fetch streams: \(error)")
            }
        }
    }
}
