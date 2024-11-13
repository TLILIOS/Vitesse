////
////  EditableCandtRow.swift
////  Vitesse
////
////  Created by TLiLi Hamdi on 07/11/2024.
////
//import SwiftUI
//
//struct EditableCandtRow: View {
//    let candidate: Candidate
//    let isFavorite: Bool
//    let selectedCandidates: Set<String>     // Ensemble des candidats sélectionnés par ID
//    let toggleFavorite: () -> Void
//    let toggleSelection: () -> Void         // Action pour basculer la sélection
//
//    var body: some View {
//        HStack {
//            // Indicateur de sélection
//            Button(action: toggleSelection) {
//                Circle()
//                    .fill(selectedCandidates.contains(candidate.id) ? Color.gray : Color.white)
//                    .frame(width: 30, height: 30)
//                    .overlay(
//                        Circle()
//                            .stroke(Color.gray, lineWidth: 1)
//                    )
//            }
//
//            // Nom du candidat
//            Text(candidate.name)
//                .font(.headline)
//                .padding(.vertical, 5)
//
//            Spacer()
//
//            // Étoile pour marquer comme favori
//            Button(action: toggleFavorite) {
//                Image(systemName: isFavorite ? "star.fill" : "star")
//                    .foregroundColor(isFavorite ? .yellow : .gray)
//            }
//            .buttonStyle(BorderlessButtonStyle())
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//        .padding(.horizontal)
//    }
//}
//
//#Preview {
//    EditableCandtRow(
//        candidate: Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"),
//        isFavorite: true,
//        selectedCandidates: ["1"],          // Exemple d'ID sélectionné
//        toggleFavorite: {
//            print("Toggle favorite")
//        },
//        toggleSelection: {
//            print("Toggle selection")
//        }
//    )
//}
