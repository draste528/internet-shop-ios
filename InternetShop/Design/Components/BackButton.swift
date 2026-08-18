//
//  BackButton.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import SwiftUI

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .fontWeight(.semibold)
                .foregroundStyle(Color.appPrimary)
        }
    }
}