//
//  ItemsListViewModel.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//

import Combine
import Foundation

@MainActor
final class ItemsListViewModel: BaseScreenViewModel {
    @Published private(set) var items: [Item] = []
    @Published var searchText: String = ""
    
    let category: Category
    private let service: ItemsService

    var filteredItems: [Item] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    init(category: Category, service: ItemsService = MockItemsService()) {
        self.category = category
        self.service = service
        
        let kind = CategoryKind(rawValue: category.name.uppercased())
        super.init(title: kind?.title ?? category.name.capitalized)
    }

    func loadItems() async {
        await load {
            self.items = try await service.fetchItems(for: category)
        }
    }
}
