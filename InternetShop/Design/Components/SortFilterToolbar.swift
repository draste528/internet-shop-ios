//
//  SortFilterToolbar.swift
//  InternetShop
//
//  Created by kair on 24.10.26.
//

import SwiftUI

/// Sort and filter buttons placed on the trailing side of the navigation bar.
struct SortFilterToolbar: ToolbarContent {
    var onSort: () -> Void = {}
    var onFilter: () -> Void = {}

    private let iconSide: CGFloat = 23

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            button(icon: "Sorting", label: "Sort", action: onSort)
            button(icon: "filter", label: "Filter", action: onFilter)
        }
    }

    private func button(icon: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: iconSide, height: iconSide)
                .foregroundStyle(Color.appGray)
        }
        .accessibilityLabel(label)
    }
}
