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
    // create singleton object
    static let shared = AVPlayerManager()
    
    // aws livestream url
    let awsStreamURL = URL(string: "https://c1c3ba7f553a.us-east-1.playback.live-video.net/api/video/v1/us-east-1.080740216434.channel.a1p4kxOjkwVx.m3u8")!
    
    // AVPlayer object
    private let player = AVPlayer()
    
    // player view controller
    private let playerController = AVPlayerViewController()

    // play live stream url
    func playLiveStream(_ vc:UIViewController){
        playStream(withURL: awsStreamURL, vc)
    }
    
    // play passed url
    func playStream(withURL url:URL, _ screen:UIViewController) {
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        screen.present(playerController, animated: true) {

            self.player.play()
        }
    }
    
    private init() {
        playerController.player = player
    }
}
