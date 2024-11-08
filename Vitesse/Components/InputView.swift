//
//  InputView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 02/11/2024.
//

import SwiftUI

struct InputView: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .autocapitalization(.none)
            }
        }
    }
}

#Preview {
    InputView(label: "Login", placeholder: "Name@example.com", text: .constant("!!!"))
}
