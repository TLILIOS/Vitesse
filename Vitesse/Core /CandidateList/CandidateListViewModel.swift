//
//  CandidateListViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 14/11/2024.
//

import Foundation

class CandidateListViewModel: ObservableObject {
    @Published var candidates: [Candidate] = []
    @Published var errorMessage: String?

    func fetchCandidates() {
        NetworkService.shared.performRequest(
            endpoint: .fetchCandidates,
            responseType: [Candidate].self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let candidates):
                    self?.candidates = candidates
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func deleteCandidate(id: String) {
        NetworkService.shared.performRequest(
            endpoint: .deleteCandidate(id: id),
            responseType: EmptyResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.candidates.removeAll { $0.id == id }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
