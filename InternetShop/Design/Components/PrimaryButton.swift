//
//  PrimaryButton.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    var background: Color = .appPrimary
    var foreground: Color = .appWhite
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBodySemibold)
                .foregroundStyle(foreground)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
