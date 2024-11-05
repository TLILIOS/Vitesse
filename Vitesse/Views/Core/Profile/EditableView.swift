//
//  EditableView.swift
//  Vitesse
//
//  Created by MacBook Air on 05/11/2024.
//

import SwiftUI

struct FideView: View {
    var body: some View {
        VStack {
            Text("Édition des candidats")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Contenu de l'édition
            Text("Options d'édition et d'autres fonctionnalités ici")
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("Éditer", displayMode: .inline)
    }
}

#Preview {
    FideView()
}

