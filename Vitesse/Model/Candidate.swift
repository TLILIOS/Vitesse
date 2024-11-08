//
//  Candidate.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 04/11/2024.
//

import Foundation

struct Candidate: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
}

extension Candidate {
    static var MockCandidate =  Candidate(id: NSUUID().uuidString, name: "Ben Affleck", email: "Affleck@gmail.com")
}

 var candidates: [Candidate] = [
        Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Jennifer Lopez", email: "jlopez@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Matt Damon", email: "matt.damon@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Scarlett Johansson", email: "scarlett.j@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Chris Hemsworth", email: "chris.hemsworth@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Robert Downey Jr.", email: "robert.dj@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Emma Stone", email: "emma.stone@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Ryan Gosling", email: "ryan.gosling@gmail.com")
]
