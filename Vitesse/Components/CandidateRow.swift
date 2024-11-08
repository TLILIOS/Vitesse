//
//  CandidateRow.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 05/11/2024.
//

import SwiftUI

struct CandidateRow: View {
    let candidate: Candidate
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    var body: some View {
        HStack {
            // Nom du candidat
            Text(candidate.name)
                .font(.headline)
                .padding(.vertical, 5)

            Spacer()

            // Étoile pour marquer comme favori
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
    }
}

#Preview {
    CandidateRow(candidate: Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"), isFavorite: true) {
        print("Toggle favorite")
    }
}
