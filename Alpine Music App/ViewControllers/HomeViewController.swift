//
//  HomeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit
import AVKit

class HomeVC: UIViewController {
    // table of previous streams
    @IBOutlet var streamView: UITableView!
    // live stream view
    @IBOutlet weak var currentStreamView: UIStackView!
    // previous stream objects to be displayed
    @Published var streams = [Stream]()
    // streams networking object
    private let streamsRepository: StreamsRepositoryProtocol = StreamsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set tap handler for livestream view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(streamViewTapped(tapGestureRecognizer:)))
        currentStreamView.isUserInteractionEnabled = true
        currentStreamView.addGestureRecognizer(tapGestureRecognizer)
        
        fetchStreams()
        streamView.accessibilityIdentifier = "streamView"
        streamView.delegate = self
        streamView.dataSource = self
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
                streamView.reloadData()
            } catch {
                print("Cannoth fetch streams: \(error)")
            }
        }
    }
}
