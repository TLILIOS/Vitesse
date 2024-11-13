//
//  AuthResponse.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation
struct AuthResponse: Decodable {
    let token: String
    let isAdmin: Bool
}
