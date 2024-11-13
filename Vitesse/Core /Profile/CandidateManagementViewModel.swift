//
//  CandidateManagementViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

class CandidateManagementViewModel: ObservableObject {
    @Published var candidates: [Candidate] = []
    @Published var errorMessage: String?

    func fetchCandidates() {
        NetworkService.shared.fetchCandidates { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let candidatesList):
                    self.candidates = candidatesList
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
