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
    var previewImageURL:String
    // the title to display
    var title: String
    // the stream URL
    var sourceURL:String
}

extension Stream{
    static let testStream = Stream(previewImageURL: "https://drive.google.com/uc?id=1XPAU7Kxii6jxIZdnLABV6OQWAC-KdUAl",
                                   title: "Bloomberg Asia",
                                   sourceURL: "https://www.bloomberg.com/media-manifest/streams/asia.m3u8")
}
