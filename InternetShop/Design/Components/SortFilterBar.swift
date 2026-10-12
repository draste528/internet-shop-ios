//
//  SortFilterBar.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import SwiftUI

struct SortFilterBar: View {
    var onSort: () -> Void = {}
    var onFilter: () -> Void = {}

    private let iconSide: CGFloat = 23

    var body: some View {
        HStack(spacing: 0) {
            button(icon: "Sorting", label: "Sort", action: onSort)
            button(icon: "filter", label: "Filter", action: onFilter)
        }
        .frame(height: 48)
        .background(Color.appDisabled)
        .overlay(alignment: .top) { divider }
        .overlay(alignment: .bottom) { divider }
    }

    private func button(icon: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: iconSide, height: iconSide)
                .foregroundStyle(Color.appGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }

    private var divider: some View {
        Rectangle().fill(Color.appLightGray).frame(height: 1)
    }
}
