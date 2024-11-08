//
//  EditProfileView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 07/11/2024.
//
import SwiftUI

struct EditProfileView: View {
    @State private var email: String
    @State private var linkedin: String
    @State private var note: String
    @State private var isModified: Bool = false  // Pour suivre les modifications
    
    var candidate: Candidate

    init(candidate: Candidate) {
        self.candidate = candidate
        _email = State(initialValue: candidate.email)
        _linkedin = State(initialValue: "") // Tu peux initialiser avec l'email LinkedIn du candidat si nécessaire
        _note = State(initialValue: "Développeur iOS passionné avec plus de 5 années d'expérience dans la conception, le développement et le déploiement d'applications mobiles performantes. Expert en Swift et SwiftUI, je maîtrise également les principes de l'architecture MVVM et l'intégration d'API RESTful. Doté d'une solide compréhension des besoins des utilisateurs, je m'efforce de créer des interfaces intuitives et des expériences fluides. Compétent en gestion du cycle de vie complet des applications, de la conception initiale à la publication sur l'App Store. Je possède une expérience pratique en optimisation des performances et en utilisation des frameworks Apple, comme CoreData et Combine. Mon approche collaborative et mon esprit analytique me permettent de m'intégrer facilement aux équipes de développement. Passionné par les technologies innovantes, je suis constamment en veille pour proposer des solutions créatives et efficaces.") 
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                // Bouton Cancel à gauche
                Button(action: {
                    // Réinitialiser les champs aux valeurs initiales
                    email = candidate.email
                    linkedin = ""
                    isModified = false
                }) {
                    Text("Cancel")
                        .foregroundColor(isModified ? .blue : .gray)
                }
                .disabled(!isModified)  // Désactive le bouton si aucune modification
    
                Spacer()

                // Bouton Done à droite
                Button(action: {
                    // Valider les modifications (par exemple, sauvegarde dans un modèle de données)
                    // Pour l'instant, ça simule juste le retour en arrière
                    print("Modifications sauvegardées : Email: \(email), LinkedIn: \(linkedin)")
                    // Retourner à la vue précédente si aucune modification
                    if !isModified {
                        // Ajouter du code pour naviguer vers la vue précédente si nécessaire
                    }
                }) {
                    Text(isModified ? "Done" : "Back")  // Affiche Done si des modifications ont été faites, sinon Go Back
                        .foregroundColor(isModified ? .blue : .gray)
                }
                .disabled(!isModified)  // Désactive si aucune modification
            }
            .padding()

            // Label Email
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: email) { _ in
                        isModified = true  // Marque comme modifié dès qu'une modification est faite
                    }
            }
            .padding(.horizontal)

            // Label LinkedIn
            VStack(alignment: .leading, spacing: 8) {
                Text("LinkedIn")
                    .font(.headline)
                TextField("Enter LinkedIn link", text: $linkedin)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: linkedin) { _ in
                        isModified = true  // Marque comme modifié dès qu'une modification est faite
                    }
            }
            .padding(.horizontal)

            // Label "Note" (pas modifiable)
            VStack(alignment: .leading, spacing: 8) {
                Text("Note")
                    .font(.headline)
                ScrollView {
                    Text(note)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .frame(height:200)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}

#Preview {
    EditProfileView(candidate: Candidate(id: UUID().uuidString, name: "Ben Affleck", email: "affleck@gmail.com"))
}

