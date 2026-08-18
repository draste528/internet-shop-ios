//
//  SearchBar.swift
//  InternetShop
//
//  Created by kair on 14.08.26.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    var placeholder: String = "Search"

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.appGray)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .font(.appInput)
                .foregroundStyle(Color.appBlack)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)

            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.appGray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
        .background(Color.appDisabled)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
