//
//  Social.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/18/23.
//

import Foundation

// object representing a social media cell
struct Social: Codable {
    // the url for the social media icon
    var imgUrl:String
    // the text for the social media cell
    var socialCellText:String
    // the url for the social media link
    var socialUrl:String
}

extension Social {
    static let testSocial = Social(imgUrl: "https://drive.google.com/uc?id=1cNSPBCORmQlGsM_46J80lHqkYNLEMgxh", socialCellText: "Soundcloud", socialUrl: "soundcloud://")
}
