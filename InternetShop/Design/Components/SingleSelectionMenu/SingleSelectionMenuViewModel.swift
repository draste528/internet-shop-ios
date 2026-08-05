//
//  SingleSelectionMenuViewModel.swift
//  InternetShop
//
//  Created by kair on 04.08.26.
//

import SwiftUI
import Combine

final class SingleSelectionMenuViewModel: ObservableObject {

    @Published var selectedTag: Int
    let items: [any SingleSelectionMenuItem]

    init(items: [any SingleSelectionMenuItem], selectedTag: Int? = nil) {
        self.items = items
        self.selectedTag = selectedTag ?? items.first?.tag ?? 0
    }

    func item(at index: Int) -> (any SingleSelectionMenuItem)? {
        items.indices.contains(index) ? items[index] : nil
    }

    func item(withTag tag: Int) -> (any SingleSelectionMenuItem)? {
        items.first { $0.tag == tag }
    }

    func isSelected(_ item: any SingleSelectionMenuItem) -> Bool {
        item.tag == selectedTag
    }

    func color(for item: any SingleSelectionMenuItem) -> Color {
        isSelected(item) ? item.activeColor : item.inactiveColor
    }

    func select(_ item: any SingleSelectionMenuItem) {
        selectedTag = item.tag
    }
}
