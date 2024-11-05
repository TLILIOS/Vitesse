//
//  CandidateRow.swift
//  Vitesse
//
//  Created by MacBook Air on 05/11/2024.
//

import SwiftUI

struct CandidateRow: View {
    let candidate: String
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(candidate)
                    .font(.headline)
                    .padding(.vertical, 5)
                Divider()
                    .background(Color.gray)
            }
            Spacer()
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
    }
}

#Preview {
    CandidateRow(candidate: "Alice Dupont", isFavorite: true) {
        print("Toggle favorite")
    }
}

