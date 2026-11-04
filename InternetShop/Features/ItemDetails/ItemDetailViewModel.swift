//
//  ItemDetailViewModel.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import Foundation
import Combine

@MainActor
final class ItemDetailViewModel: BaseScreenViewModel {
    @Published private(set) var details: ItemDetails?
    @Published private(set) var imageURLs: [URL] = []
    @Published var selectedImageIndex = 0
    @Published private(set) var isFavorited = false
    @Published private(set) var isAddedToCart = false

    /// Request parameter: `details` (and `details.id`) is nil until loading finishes.
    private let itemId: UUID
    private let service: ItemDetailsService

    init(itemId: UUID, service: ItemDetailsService = MockItemDetailsService()) {
        self.itemId = itemId
        self.service = service
        super.init(title: "")
    }

    var navigationTitle: String { details?.name ?? "" }

    var reviews: [Review] { details?.reviews ?? [] }

    func loadDetails() async {
        do {
            try await load {
                let result = try await service.fetchDetails(for: itemId)
                details = result
                imageURLs = validURLs(from: result.thumbnails)
                isFavorited = result.isFavorited
                isAddedToCart = result.isAddedToCart
                selectedImageIndex = 0
            }
        } catch {
            errorMessage = "Failed to load item details"
        }
    }

    func toggleFavorite() { isFavorited.toggle() }
    func toggleCart() { isAddedToCart.toggle() }
    func buy() { isAddedToCart = true }

    /// Keeps only valid web or local file links, so the View never deals with optional URLs.
    private func validURLs(from strings: [String]?) -> [URL] {
        (strings ?? []).compactMap { URL(validatedString: $0) }
    }
}
