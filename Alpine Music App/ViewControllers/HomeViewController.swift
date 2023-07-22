//
//  HomeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    // table of previous streams
    @IBOutlet var streamHistory: UITableView!
    
    // live stream view
    @IBOutlet weak var liveStream: UIStackView!
    
    // previous stream objects to be displayed
    @Published var streams = [Stream]()
    
    // streams networking object
    private let streamsRepository: StreamsRepositoryProtocol = StreamsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set tap handler for livestream view
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(streamViewTapped(tapGestureRecognizer:))
        )
        liveStream.isUserInteractionEnabled = true
        liveStream.addGestureRecognizer(tapGestureRecognizer)
        
        fetchStreams()
        streamHistory.accessibilityIdentifier = "streamView"
        streamHistory.delegate = self
        streamHistory.dataSource = self
    }
    
    @objc func streamViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        // open stream view with stream channel playback url
        AVPlayerManager.shared.playLiveStream(self)
    }
    
    // load streams from firebase
    func fetchStreams() {
        Task {
            do {
                streams = try await streamsRepository.fetchStreams()
                streamHistory.reloadData()
            } catch {
                print("Cannot fetch streams: \(error)")
            }
        }
    }
}
