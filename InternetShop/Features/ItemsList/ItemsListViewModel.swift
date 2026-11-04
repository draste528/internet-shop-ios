//
//  ItemsListViewModel.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//

import Foundation
import Combine

@MainActor
final class ItemsListViewModel: BaseScreenViewModel {
    @Published private(set) var items: [Item] = []

    let category: Category
    let router: Router<CatalogRoute>
    private let service: ItemsService

    /// State of the sort/filter buttons in the navigation bar; taps are routed back to this screen.
    private(set) lazy var sortFilterToolbarViewModel = SortFilterToolbarViewModel(
        onSort: { [weak self] in self?.showSortOptions() },
        onFilter: { [weak self] in self?.showFilters() }
    )

    var filteredItems: [Item] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    init(category: Category, router: Router<CatalogRoute>, service: ItemsService = MockItemsService()) {
        self.category = category
        self.router = router
        self.service = service

        let kind = CategoryKind(rawValue: category.name.uppercased())
        super.init(title: kind?.title ?? category.name.capitalized)
    }

    func loadItems() async {
        do {
            try await load {
                self.items = try await service.fetchItems(for: category)
            }
        } catch {
            errorMessage = "Failed to load items"
        }
    }

    func showItemDetails(itemId: UUID) {
        router.push(.itemDetail(itemId: itemId))
    }

    /// Sort screen is not part of this task yet; the toolbar already routes its taps here.
    func showSortOptions() {}

    /// Filter screen is not part of this task yet; the toolbar already routes its taps here.
    func showFilters() {}
}
