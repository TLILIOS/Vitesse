//
//  Profile.swift
//  Vitesse
//
//  Created by MacBook Air on 07/11/2024.
import SwiftUI

struct CandidateDetailView: View {
    let candidate: Candidate
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Affichage des informations du candidat
            Text(candidate.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(candidate.email)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            // Bouton d'action ou autres détails
            Button(action: {
                // Action à définir pour contacter le candidat, par exemple.
            }) {
                Text("Contacter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CandidateDetailView(candidate: Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"))
}
