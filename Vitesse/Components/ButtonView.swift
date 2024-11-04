//
//  ButtonView.swift
//  Vitesse
//
//  Created by MacBook Air on 02/11/2024.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var backgroundColor = Color(.systemBlue)
    var textColor = Color.white
    var width: CGFloat = UIScreen.main.bounds.width - 200
    var height: CGFloat = 48
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .frame(width: width, height: height)
        }
        .background(backgroundColor)
        .clipShape(.buttonBorder)
    }
}

#Preview {
    ButtonView(title: "Sign In", action: {
        print("Button Pressed")
    })

}
