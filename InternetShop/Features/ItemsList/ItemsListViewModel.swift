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
        await load {
            do {
                self.items = try await service.fetchItems(for: category)
            } catch {
                self.errorMessage = "Failed to load items"
            }
        }
    }
    
    func showItemDetails(itemId: UUID) {
        router.push(.itemDetail(itemId: itemId))
    }
}
