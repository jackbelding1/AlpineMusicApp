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
    var imageURL:String
    // the text for the social media cell
    var name:String
    // the url for the social media link
    var profileURL:String
}

extension Social {
    static let testSocial = Social(imageURL: "https://drive.google.com/uc?id=1cNSPBCORmQlGsM_46J80lHqkYNLEMgxh", name: "Soundcloud", profileURL: "soundcloud://")
}
