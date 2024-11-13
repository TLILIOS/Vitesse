//
//  Candidate.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 04/11/2024.
//

import Foundation

struct Candidate: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String?
    let note: String?
    let linkedinURL: String?
    let isFavorite: Bool
}


