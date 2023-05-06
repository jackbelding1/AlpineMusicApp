//
//  AVPlayerManager.swift
//  Alpine Music App
//
//  Created by Jack Belding on 5/4/23.
//
import Foundation
import AVFoundation
import AVKit


class AVPlayerManager {
    static let shared = AVPlayerManager()
    
    let liveStreamURL = URL(string: "https://c1c3ba7f553a.us-east-1.playback.live-video.net/api/video/v1/us-east-1.080740216434.channel.a1p4kxOjkwVx.m3u8")!
    
    private let player = AVPlayer()
    
    private let playerController = AVPlayerViewController()

    // play live stream url
    func playLiveStream(_ vc:UIViewController){
        playStream(withURL: liveStreamURL, vc)
    }
    
    // play passed url
    func playStream(withURL url:URL, _ vc:UIViewController) {
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        vc.present(playerController, animated: true) {

            self.player.play()
        }
    }
    
    private init() {
        playerController.player = player
    }
}
