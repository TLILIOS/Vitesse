//
//  FavoriteCandidatesView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 05/11/2024.
//

import SwiftUI

struct FavoriteCandidatesView: View {
    @State private var searchText: String = ""                     // Texte de recherche
    @Binding var favoriteCandidates: Set<String>                   // Stocke les IDs des candidats favoris
    @Environment(\.presentationMode) private var presentationMode  // Pour revenir en arrière

    // Liste complète des candidats (utilisé pour filtrer les favoris)
    var allCandidates: [Candidate]

    var body: some View {
        VStack {
            // Barre de recherche
            TextField("Rechercher un favori...", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            if filteredFavorites.isEmpty {
                Text("Aucun favori trouvé")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Liste des favoris filtrés
                List(filteredFavorites) { candidate in
                    CandidateRow(candidate: candidate, isFavorite: true) {
                        toggleFavorite(candidate)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("Candidats", displayMode: .inline)
        .navigationBarItems(
            leading: Button("Edit") {
                // Utilisez un NavigationLink pour naviguer vers une vue d'édition si nécessaire
            },
            trailing: Button(action: {
                presentationMode.wrappedValue.dismiss() // Retour à AllCandidatesView
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        )
    }

    // Filtre les candidats favoris en fonction du texte de recherche
    private var filteredFavorites: [Candidate] {
        let favoriteList = allCandidates.filter { favoriteCandidates.contains($0.id) }
        
        if searchText.isEmpty {
            return favoriteList
        } else {
            return favoriteList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    // Basculer l'état de favori pour un candidat donné
    private func toggleFavorite(_ candidate: Candidate) {
        if favoriteCandidates.contains(candidate.id) {
            favoriteCandidates.remove(candidate.id)
        } else {
            favoriteCandidates.insert(candidate.id)
        }
    }
}

#Preview {
    FavoriteCandidatesView(
        favoriteCandidates: .constant(["1", "2"]),
        allCandidates: [
            Candidate(id: "1", name: "Alice Dupont", email: "alice@example.com"),
            Candidate(id: "2", name: "Bob Martin", email: "bob@example.com"),
            Candidate(id: "3", name: "Charlie Laroche", email: "charlie@example.com")
        ]
    )
}

