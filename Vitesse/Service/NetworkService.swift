//
//  NetworkService.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = URL(string: "http://127.0.0.1:8080")!
    private var authToken: String?
    
    private init() {}
    
    func setAuthToken(token: String) {
        self.authToken = token
    }

    func authenticate(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/user/auth")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.setAuthToken(token: authResponse.token)
                completion(.success(authResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func registerUser(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/user/register")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password, "firstName": firstName, "lastName": lastName]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(NSError(domain: "RegisterError", code: -1, userInfo: nil)))
                return
            }
            completion(.success(()))
        }.resume()
    }
    
    func fetchCandidates(completion: @escaping (Result<[Candidate], Error>) -> Void) {
        guard let authToken = authToken else {
            completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: ["message": "No auth token"])))
            return
        }
        let url = baseURL.appendingPathComponent("/candidate")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }
            do {
                let candidates = try JSONDecoder().decode([Candidate].self, from: data)
                completion(.success(candidates))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
