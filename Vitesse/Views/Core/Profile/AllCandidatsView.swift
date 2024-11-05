//
//  CandidatsView.swift
//  Vitesse
//
//  Created by MacBook Air on 05/11/2024.
//
// File: AllCandidatesView.swift
import SwiftUI

// File: AllCandidatesView.swift
import SwiftUI

struct AllCandidatesView: View {
    @State private var favoriteCandidates: Set<String> = [] // Stocke les favoris
    @State private var searchText: String = ""              // Texte de recherche
    @State private var isShowingFavoritesView = false       // Contrôle la navigation vers la vue des favoris
    @State private var isShowingFideView = false            // Contrôle la navigation vers la vue Fide

    private let candidates = [
        "Alice Dupont",
        "Bob Martin",
        "Charlie Laroche",
        "Diana Poirier",
        "Ethan Moreau",
        "Fiona Langlois"
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Barre de recherche
                TextField("Rechercher un candidat...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Liste de tous les candidats avec étoiles pour les favoris
                List(filteredCandidates, id: \.self) { candidate in
                    CandidateRow(candidate: candidate, isFavorite: favoriteCandidates.contains(candidate)) {
                        toggleFavorite(candidate)
                    }
                }
                .listStyle(PlainListStyle())

                // NavigationLink pour FavoriteCandidatesView
                NavigationLink(
                    destination: FavoriteCandidatesView(favoriteCandidates: $favoriteCandidates),
                    isActive: $isShowingFavoritesView
                ) {
                    EmptyView()
                }

                // NavigationLink pour FideView
                NavigationLink(
                    destination: FideView(),
                    isActive: $isShowingFideView
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Condidats", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Edit") {
                    isShowingFideView = true // Active la vue Fide
                },
                trailing: Button(action: {
                    isShowingFavoritesView = true // Active la vue des favoris
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            )
        }
    }
    
    // Filtre les candidats en fonction du texte de recherche
    private var filteredCandidates: [String] {
        if searchText.isEmpty {
            return candidates
        } else {
            return candidates.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    // Basculer les favoris
    private func toggleFavorite(_ candidate: String) {
        if favoriteCandidates.contains(candidate) {
            favoriteCandidates.remove(candidate)
        } else {
            favoriteCandidates.insert(candidate)
        }
    }
}

#Preview {
    AllCandidatesView()
}
