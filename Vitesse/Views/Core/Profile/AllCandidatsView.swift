//
//  AllCandidatsView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 05/11/2024.
//
import SwiftUI

struct AllCandidatesView: View {
    @State private var favoriteCandidates: Set<String> = [] // Stocke les favoris par ID
    @State private var searchText: String = ""
    @State private var isShowingFavoritesView = false
    @State private var isShowingEditableView = false
    @State private var candidateDetailView: Set<String> = []

    var body: some View {
        
            VStack {
                // Barre de recherche
                TextField("Rechercher un candidat...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Liste des candidats avec lignes cliquables
                List(filteredCandidates) { candidate in
                    NavigationLink(destination: CandidateDetailView(candidate: candidate, isFavorite: favoriteCandidates.contains(candidate.id))) {
                        CandidateRow(candidate: candidate, isFavorite: favoriteCandidates.contains(candidate.id)) {
                            toggleFavorite(candidate)
                        }
                    }
                }
                .listStyle(PlainListStyle())

                // Navigation vers la vue FavoriteCandidatesView
                NavigationLink(
                    destination: FavoriteCandidatesView(
                        favoriteCandidates: $favoriteCandidates,
                        allCandidates: candidates
                    ),
                    isActive: $isShowingFavoritesView
                ) {
                    EmptyView()
                }

                // Navigation vers la vue EditableView
                NavigationLink(
                    destination: EditableView(),
                    isActive: $isShowingEditableView
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Candidats", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Edit") {
                    isShowingEditableView = true // Active la vue EditableView
                },
                trailing: Button(action: {
                    isShowingFavoritesView = true // Active la vue des favoris
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            )
        
    }
    
    // Filtre les candidats en fonction du texte de recherche
    private var filteredCandidates: [Candidate] {
        if searchText.isEmpty {
            return candidates
        } else {
            return candidates.filter { $0.name.lowercased().contains(searchText.lowercased()) }
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
    NavigationView {
        AllCandidatesView()
    }
    
}
