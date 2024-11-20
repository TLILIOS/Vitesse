//
//  CandidateDetailViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 15/11/2024.
//

import Foundation

class CandidateDetailViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var candidate: Candidate
    @Published var phone: String
    @Published var email: String
    @Published var linkedinURL: String
    @Published var note: String
    @Published var isAdmin: Bool
    private let originalCandidate: Candidate
    
    init(candidate: Candidate, isAdmin: Bool) {
        self.candidate = candidate
        self.phone = candidate.phone ?? ""
        self.email = candidate.email
        self.linkedinURL = candidate.linkedinURL ?? ""
        self.note = candidate.note ?? ""
        self.isAdmin = isAdmin
        self.originalCandidate = candidate
    }
    
    // Reset fields to the original candidate data
    func resetFields() {
        self.phone = originalCandidate.phone ?? ""
        self.email = originalCandidate.email
        self.linkedinURL = originalCandidate.linkedinURL ?? ""
        self.note = originalCandidate.note ?? ""
    }
    
    // Update the candidate information on the server
    func updateCandidate() {
        NetworkService.shared.performRequest(
            endpoint: .updateCandidate(id: candidate.id, firstName: candidate.firstName, lastName: candidate.lastName, email: email, phone: phone, linkedinURL: linkedinURL, note: note),
            responseType: Candidate.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedCandidate):
                    self?.candidate = updatedCandidate
                    self?.showAlert = true
                case .failure(let error):
                    print("Failed to update candidate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Toggle favorite status (only if user is admin)
    func toggleFavoriteStatus() {
        guard isAdmin else { return }
        
        NetworkService.shared.performRequest(
            endpoint: .updateFavoriteStatus(id: candidate.id, isFavorite: !candidate.isFavorite),
            responseType: Candidate.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedCandidate):
                    self?.candidate.isFavorite = updatedCandidate.isFavorite
                case .failure(let error):
                    print("Failed to toggle favorite status: \(error.localizedDescription)")
                }
            }
        }
    }
}

