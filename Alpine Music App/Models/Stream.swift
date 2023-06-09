//
//  Stream.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/14/23.
//

import Foundation

// object representing a pre recorded stream fetched from firebase
struct Stream: Codable {
    // url for stream thumbnail
    var thumbnailUrl:String
    // the title to display
    var title: String
    // the stream URL
    var url:String
}

extension Stream{
    static let testStream = Stream(thumbnailUrl: "https://drive.google.com/uc?id=1XPAU7Kxii6jxIZdnLABV6OQWAC-KdUAl",
                                   title: "Bloomberg Asia",
                                   url: "https://www.bloomberg.com/media-manifest/streams/asia.m3u8")
}
