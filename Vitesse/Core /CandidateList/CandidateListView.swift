//
//  CandidateListView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 15/11/2024.
//

import SwiftUI
import UIKit

struct CandidateListView: View {
    @StateObject private var viewModel = CandidateListViewModel()
    @State private var isEditing = false
    @State private var searchText = ""
    @State private var showOnlyFavorites = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Barre de recherche
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                // Toggle pour afficher seulement les favoris
                Toggle("Show Favorites Only", isOn: $showOnlyFavorites)
                    .padding(.horizontal)
                
                // Liste des candidats
                List {
                    ForEach(viewModel.candidates, id: \.id) { candidate in
//                        NavigationLink(destination: CandidateDetailView(viewModel: candidate)) {
                            CandidateRow(candidate: candidate)
//                        }
                    }
                    .onDelete { indexSet in
//                        $viewModel.deleteCandidates(at: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Candidates")
            .navigationBarItems(
                leading: Button("Edit") {
                    isEditing.toggle()
                },
                trailing: Button("Refresh") {
                    viewModel.fetchCandidates()
                }
            )
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
            .onAppear {
                viewModel.fetchCandidates()
            }
        }
    }
}

// Composant pour afficher un candidat dans une ligne de la liste
struct CandidateRow: View {
    let candidate: Candidate

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(candidate.firstName) \(candidate.lastName)")
                    .font(.headline)
                Text(candidate.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if candidate.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 8)
    }
}

// - MARK

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            text = ""
            searchBar.endEditing(true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search candidates"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

