//
//  NetworkService.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

// Enum définissant les méthodes HTTP
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// Enum regroupant tous les points d'accès de l'API
enum NetworkEndPoint {
    case authenticate(email: String, password: String)
    case register(email: String, password: String, firstName: String, lastName: String)
    case fetchCandidates
    case getCandidate(id: String)
    case createCandidate(firstName: String, lastName: String, email: String, phone: String?, linkedinURL: String?, note: String?, isFavorite: Bool)
    case updateCandidate(id: String, firstName: String, lastName: String, email: String, phone: String?, linkedinURL: String?, note: String?)
    case deleteCandidate(id: String)
    case updateFavoriteStatus(id: String, isFavorite: Bool)
    
    // Définition de la méthode HTTP pour chaque endpoint
    var method: HTTPMethod {
        switch self {
        case .authenticate, .register, .createCandidate:
            return .post
        case .fetchCandidates, .getCandidate:
            return .get
        case .updateCandidate, .updateFavoriteStatus:
            return .put
        case .deleteCandidate:
            return .delete
        }
    }
    
    // Chemin pour chaque endpoint
    var path: String {
        switch self {
        case .authenticate:
            return "/user/auth"
        case .register:
            return "/user/register"
        case .fetchCandidates:
            return "/candidate"
        case .getCandidate(let id):
            return "/candidate/\(id)"
        case .createCandidate:
            return "/candidate"
        case .updateCandidate(let id):
            return "/candidate/\(id)"
        case .deleteCandidate(let id):
            return "/candidate/\(id)"
        case .updateFavoriteStatus(let id, _):
            return "/candidate/\(id)/favorite"
        }
    }
    
    // Paramètres pour chaque endpoint
    var parameters: [String: Any]? {
        switch self {
        case .authenticate(let email, let password):
            return ["email": email, "password": password]
        case .register(let email, let password, let firstName, let lastName):
            return [
                "email": email,
                "password": password,
                "firstName": firstName,
                "lastName": lastName
            ]
        case .createCandidate(let firstName, let lastName, let email, let phone, let linkedinURL, let note, let isFavorite):
            return [
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "phone": phone ?? "",
                "linkedinURL": linkedinURL ?? "",
                "note": note ?? "",
                "isFavorite": isFavorite
            ]
        case .updateCandidate(_, let firstName, let lastName, let email, let phone, let linkedinURL, let note):
            return [
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "phone": phone ?? "",
                "linkedinURL": linkedinURL ?? "",
                "note": note ?? ""
            ]
        case .updateFavoriteStatus(_, let isFavorite):
            return ["isFavorite": isFavorite]
        default:
            return nil
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = URL(string: "http://127.0.0.1:8080")!
    private var authToken: String?
    
    private init() {}
    
    // Méthode pour enregistrer le token après authentification
    func setAuthToken(_ token: String) {
        self.authToken = token
    }
    
    // Méthode générique pour exécuter une requête réseau
    func performRequest<T: Decodable>(endpoint: NetworkEndPoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL.absoluteString + endpoint.path) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Ajout du token d'autorisation si présent
        if let authToken = authToken {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        // Encodage des paramètres pour les requêtes non-GET
        if let parameters = endpoint.parameters, endpoint.method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "HTTP Error", code: -1, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
