//
//  StreamRepository.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/16/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol StreamsRepositoryProtocol {
    func fetchStreams() async throws -> [Stream]
}

struct StreamsRepository: StreamsRepositoryProtocol {
    let streamsReference = Firestore.firestore().collection("streams")
    
    func fetchStreams() async throws -> [Stream] {
        let snapshot = try await streamsReference.getDocuments()
        let streams = snapshot.documents.map { document in
            try! document.data(as: Stream.self)
        }
        return streams
    }
}

