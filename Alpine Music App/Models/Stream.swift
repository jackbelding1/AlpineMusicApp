//
//  Stream.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/14/23.
//

import Foundation

struct Stream {
    var title: String
    var url:String
}

extension Stream {
    static let testStream = Stream(title: "Bloomberg Asia",
                                   url: "https://www.bloomberg.com/media-manifest/streams/asia.m3u8")
}
