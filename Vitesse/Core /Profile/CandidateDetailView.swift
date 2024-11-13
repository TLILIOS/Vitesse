//
//  Profile.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 07/11/2024.

import SwiftUI

struct CandidateDetailView: View {
    var note: String = "Développeur iOS passionné avec plus de 5 années d'expérience dans la conception, le développement et le déploiement d'applications mobiles performantes. Expert en Swift et SwiftUI, je maîtrise également les principes de l'architecture MVVM et l'intégration d'API RESTful. Doté d'une solide compréhension des besoins des utilisateurs, je m'efforce de créer des interfaces intuitives et des expériences fluides. Compétent en gestion du cycle de vie complet des applications, de la conception initiale à la publication sur l'App Store. Je possède une expérience pratique en optimisation des performances et en utilisation des frameworks Apple, comme CoreData et Combine. Mon approche collaborative et mon esprit analytique me permettent de m'intégrer facilement aux équipes de développement. Passionné par les technologies innovantes, je suis constamment en veille pour proposer des solutions créatives et efficaces."
    let candidate: Candidate
    let isFavorite: Bool            // Indique si le candidat est favori
    var isAdmin: Bool = true         // Indique si l'utilisateur est un administrateur (par défaut true pour l'exemple)
    @State private var favoriteStatus: Bool // État interne pour gérer le favori

    init(candidate: Candidate, isFavorite: Bool, isAdmin: Bool = true) {
        self.candidate = candidate
        self.isFavorite = isFavorite
        self.isAdmin = isAdmin
        _favoriteStatus = State(initialValue: isFavorite)
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(candidate.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Étoile pour indiquer l'état de favori
                if isAdmin {
                    Button(action: {
                        favoriteStatus.toggle()
                    }) {
                        Image(systemName: favoriteStatus ? "star.fill" : "star")
                            .foregroundColor(favoriteStatus ? .yellow : .gray)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                } else {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
            }

            Text(candidate.email)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            // Bouton pour acceder au LinkedIn du candidat
            HStack {
                Text("LinkedIn")
                
                    .font(.headline)
                    .padding()
                Button(action: {
                    print("Go on LinkedIn pressed!!!")
                }) {
                    Text("Go on LinkedIn")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(30)
            Spacer()
            // Label "Note"
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Note")
                                .font(.headline)
                            
                            // Texte non éditable pour afficher la note
                            
                            ScrollView {
                                Text(note)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                            .frame(height: 200)
                        }
                        .padding(.horizontal)
        }
        .padding()
        .navigationBarTitle("Profil", displayMode: .inline)
        .navigationBarItems(
            trailing: NavigationLink("Edit", destination: EditProfileView(candidate: candidate))
        )
    }
}

#Preview {
    CandidateDetailView(
        candidate: Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"),
        isFavorite: true,
        isAdmin: true
    )
}
