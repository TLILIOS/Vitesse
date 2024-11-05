//
//  ButtonView.swift
//  Vitesse
//
//  Created by MacBook Air on 02/11/2024.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var backgroundColor: Color = .blue
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()  // Appelle l'action seulement si elle est définie
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(5)  // Utilise des coins arrondis
        }
    }
}

#Preview {
    ButtonView(title: "Sign In", action: {
        print("Button Pressed")
    })
}
