//
//  EditableView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 05/11/2024.
//

import SwiftUI

struct EditableView: View {
    @State private var searchText: String = ""                      // Texte de recherche
    @State private var selectedCandidates: Set<String> = []         // Stocke les ID des candidats sélectionnés
    @State private var favoriteCandidates: Set<String> = []         // Stocke les ID des favoris
    @Environment(\.presentationMode) private var presentationMode   // Pour navigation arrière

    var body: some View {
                    VStack {
                // Barre de recherche
                TextField("Rechercher un candidat...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Liste de candidats
                List(filteredCandidates) { candidate in
                    HStack {
                        // Nom et gestion de favori
                        EditableCandtRow(
                            candidate: candidate,
                            isFavorite: favoriteCandidates.contains(candidate.id),
                            selectedCandidates: selectedCandidates,
                            toggleFavorite: { toggleFavorite(candidate) },
                            toggleSelection: { toggleSelection(for: candidate) }
                        )
                        Spacer()
                    }
                    .contentShape(Rectangle()) // Rendre la ligne cliquable dans son intégralité
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Candidats", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    if selectedCandidates.isEmpty {
                        presentationMode.wrappedValue.dismiss() // Retour à la vue précédente
                    } else {
                        selectedCandidates.removeAll() // Désélectionne tous les candidats
                    }
                },
                trailing: Button("Delete") {
                    deleteSelectedCandidates()
                }
                .disabled(selectedCandidates.isEmpty) // Désactive le bouton si aucune sélection
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

    // Bascule l'état de sélection pour un candidat donné
    private func toggleSelection(for candidate: Candidate) {
        if selectedCandidates.contains(candidate.id) {
            selectedCandidates.remove(candidate.id)
        } else {
            selectedCandidates.insert(candidate.id)
        }
    }

    // Bascule l'état de favori pour un candidat donné
    private func toggleFavorite(_ candidate: Candidate) {
        if favoriteCandidates.contains(candidate.id) {
            favoriteCandidates.remove(candidate.id)
        } else {
            favoriteCandidates.insert(candidate.id)
        }
    }

    // Supprime les candidats sélectionnés
    private func deleteSelectedCandidates() {
        candidates.removeAll { selectedCandidates.contains($0.id) }
        selectedCandidates.removeAll() // Efface la sélection après suppression
    }
}

#Preview {
    NavigationView {
        EditableView()
    }
    
}
