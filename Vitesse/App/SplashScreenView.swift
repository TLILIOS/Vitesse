//
//  SplashScreenView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 07/11/2024.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false  // Variable pour gérer la transition vers la vue principale

    var body: some View {
        if isActive {
            // Navigue vers la vue principale de l'application
            AuthenticationView() // Remplace avec la vue principale de ton application
        } else {
            VStack {
                Spacer()
                // Affiche le logo
                Image("Vitesse_P6")
                    .resizable()
                    .frame(width: 350, height: 100)
                    .foregroundColor(.blue)
                
                Spacer()
            }
            .onAppear {
                // Temporisateur pour simuler le délai d'affichage de l'écran de lancement
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    SplashScreenView()
}
