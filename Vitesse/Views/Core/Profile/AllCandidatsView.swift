//
//  CandidatsView.swift
//  Vitesse
//
//  Created by MacBook Air on 05/11/2024.
//
import SwiftUI

struct AllCandidatesView: View {
    @State private var favoriteCandidates: Set<String> = [] // Stocke les favoris par ID
    @State private var searchText: String = ""              // Texte de recherche
    @State private var isShowingFavoritesView = false       // Contrôle la navigation vers la vue des favoris
    @State private var isShowingFideView = false            // Contrôle la navigation vers la vue Fide
    @State private var candidateDetailView: Set<String> = []
    // Liste des candidats importée de User.swift
    private var candidates: [Candidate] = [
        Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Jennifer Lopez", email: "jlopez@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Matt Damon", email: "matt.damon@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Scarlett Johansson", email: "scarlett.j@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Chris Hemsworth", email: "chris.hemsworth@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Robert Downey Jr.", email: "robert.dj@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Emma Stone", email: "emma.stone@gmail.com"),
        Candidate(id: UUID().uuidString, name: "Ryan Gosling", email: "ryan.gosling@gmail.com")
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
                    isActive: $isShowingFideView
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Candidats", displayMode: .inline)
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
    AllCandidatesView()
}
