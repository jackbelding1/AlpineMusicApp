//
//  Social.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/18/23.
//

import Foundation

struct Social: Codable {
    var imgUrl:String
    var socialCellText:String
    var socialUrl:String
}

extension Social {
    static let testSocial = Social(imgUrl: "https://drive.google.com/uc?id=1cNSPBCORmQlGsM_46J80lHqkYNLEMgxh", socialCellText: "Soundcloud", socialUrl: "soundcloud://")
}
