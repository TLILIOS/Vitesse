//
//  AllCandidatsView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 05/11/2024.
//
import SwiftUI

struct AllCandidatesView: View {
    @StateObject private var viewModel = CandidateManagementViewModel() // Instance de CandidateManagementViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("All Candidates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.candidates.isEmpty {
                    Text("No candidates available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.candidates, id: \.id) { candidate in
                        CandidateRow(candidate: candidate)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchCandidates() // Charger les candidats quand la vue apparaît
            }
        }
    }
}

// Vue pour afficher les détails de chaque candidat
struct CandidateRow: View {
    let candidate: Candidate

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(candidate.firstName) \(candidate.lastName)")
                .font(.headline)
            Text(candidate.email)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    AllCandidatesView()
}
