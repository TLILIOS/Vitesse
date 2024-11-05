//
//  User.swift
//  Vitesse
//
//  Created by MacBook Air on 04/11/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
}

extension User {
    static var MockUser =  User(id: NSUUID().uuidString, name: "Ben Affleck", email: "Affleck@gmail.com")
    }

