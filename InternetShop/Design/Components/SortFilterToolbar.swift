//
//  SortFilterToolbar.swift
//  InternetShop
//
//  Created by kair on 24.10.26.
//

import SwiftUI

/// Sort and filter buttons placed on the trailing side of the navigation bar.
/// All state and tap handling live in `SortFilterToolbarViewModel`.
struct SortFilterToolbar: ToolbarContent {
    let viewModel: SortFilterToolbarViewModel

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            SortFilterToolbarButton(kind: .sort, viewModel: viewModel)
            SortFilterToolbarButton(kind: .filter, viewModel: viewModel)
        }
    }
}

/// A single toolbar button; observes the view model so its color follows the applied state.
private struct SortFilterToolbarButton: View {
    let kind: SortFilterButtonKind
    @ObservedObject var viewModel: SortFilterToolbarViewModel

    private let iconSide: CGFloat = 23

    var body: some View {
        let isApplied = viewModel.isApplied(kind)
        Button {
            viewModel.didTap(kind)
        } label: {
            Image(kind.iconName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: iconSide, height: iconSide)
                .foregroundStyle(isApplied ? Color.appPrimary : Color.appGray)
        }
        .accessibilityLabel(kind.accessibilityLabel)
        .accessibilityAddTraits(isApplied ? .isSelected : [])
    }
}
