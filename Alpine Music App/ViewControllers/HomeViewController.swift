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
    @IBOutlet weak var currentStreamView: UIStackView!
    
    
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
        // open stream view with stream channel playback url
        AVPlayerManager.shared.playLiveStream(self)
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
