//
//  FavoriteCandidatesView.swift
//  Vitesse
//
//  Created by MacBook Air on 05/11/2024.
//
// File: FavoriteCandidatesView.swift
import SwiftUI

struct FavoriteCandidatesView: View {
    @State private var searchText: String = ""                  // Texte de recherche
    @Binding var favoriteCandidates: Set<String>                // Liée aux favoris dans AllCandidatesView
    @Environment(\.presentationMode) var presentationMode       // Pour revenir en arrière

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
                // Liste des favoris
                List(filteredFavorites, id: \.self) { candidate in
                    CandidateRow(candidate: candidate, isFavorite: true) {
                        toggleFavorite(candidate)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("Condidats", displayMode: .inline)
        .navigationBarItems(
            leading: Button("Edit") {
                // Naviguer vers FideView
                // Utilisez un NavigationLink si nécessaire pour un accès direct
                // via `presentationMode`, ou modifiez `AllCandidatesView` pour cet accès
            },
            trailing: Button(action: {
                presentationMode.wrappedValue.dismiss() // Retour à AllCandidatesView
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        )
    }

    // Filtre les favoris en fonction du texte de recherche
    private var filteredFavorites: [String] {
        if searchText.isEmpty {
            return Array(favoriteCandidates)
        } else {
            return favoriteCandidates.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    // Basculer les favoris
    private func toggleFavorite(_ candidate: String) {
        favoriteCandidates.remove(candidate)
    }
}

#Preview {
    FavoriteCandidatesView(favoriteCandidates: .constant(["Alice Dupont", "Bob Martin"]))
}
