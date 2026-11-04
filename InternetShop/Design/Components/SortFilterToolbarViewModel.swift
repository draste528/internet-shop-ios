//
//  SortFilterToolbarViewModel.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

import Foundation
import Combine

/// Buttons shown by `SortFilterToolbar`.
enum SortFilterButtonKind: CaseIterable {
    case sort
    case filter

    var iconName: String {
        switch self {
        case .sort: "Sorting"
        case .filter: "filter"
        }
    }

    var accessibilityLabel: String {
        switch self {
        case .sort: "Sort"
        case .filter: "Filter"
        }
    }
}

/// State and tap handling for the sort/filter navigation bar buttons.
/// The owning screen sets `isSortApplied` / `isFilterApplied` and the toolbar highlights the buttons accordingly.
@MainActor
final class SortFilterToolbarViewModel: ObservableObject {
    @Published var isSortApplied: Bool
    @Published var isFilterApplied: Bool

    private let onSort: () -> Void
    private let onFilter: () -> Void

    init(
        isSortApplied: Bool = false,
        isFilterApplied: Bool = false,
        onSort: @escaping () -> Void = {},
        onFilter: @escaping () -> Void = {}
    ) {
        self.isSortApplied = isSortApplied
        self.isFilterApplied = isFilterApplied
        self.onSort = onSort
        self.onFilter = onFilter
    }

    func isApplied(_ kind: SortFilterButtonKind) -> Bool {
        switch kind {
        case .sort: isSortApplied
        case .filter: isFilterApplied
        }
    }

    func didTap(_ kind: SortFilterButtonKind) {
        switch kind {
        case .sort: onSort()
        case .filter: onFilter()
        }
    }
}
