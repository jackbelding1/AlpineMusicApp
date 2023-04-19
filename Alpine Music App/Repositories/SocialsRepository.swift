//
//  SocialsRepository.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol SocialsRepositoryProtocol {
    func fetchSocials() async throws -> [Social]
}

struct SocialsRepository: SocialsRepositoryProtocol {
    let socialsReference = Firestore.firestore().collection("socials")
    
    func fetchSocials() async throws -> [Social] {
        let snapshot = try await socialsReference.getDocuments()
        let socials = snapshot.documents.map { document in
            try! document.data(as: Social.self)
        }
        return socials
    }
}

