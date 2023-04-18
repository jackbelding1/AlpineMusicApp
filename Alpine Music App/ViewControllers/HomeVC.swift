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
    
    @Published var streams = [Stream]()
    let player = AVPlayer()
    let PlayerController = AVPlayerViewController()
    private let streamsRepository: StreamsRepositoryProtocol = StreamsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStreams()
        streamView.delegate = self
        streamView.dataSource = self
        PlayerController.player = player
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
