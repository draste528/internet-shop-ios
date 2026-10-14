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
    @Published var selectedImageIndex = 0
    @Published private(set) var selectedReviewIndex = 0
    @Published private(set) var isFavorited = false
    @Published private(set) var isAddedToCart = false

    let itemId: UUID
    private let service: ItemDetailsService

    init(itemId: UUID, service: ItemDetailsService = MockItemDetailsService()) {
        self.itemId = itemId
        self.service = service
        super.init(title: "")
    }

    var navigationTitle: String { details?.name ?? "" }

    var imageURLs: [URL?] {
        (details?.thumbnails ?? []).map { URL(string: $0) }
    }

    var reviews: [Review] { details?.reviews ?? [] }

    var currentReview: Review? {
        reviews.indices.contains(selectedReviewIndex) ? reviews[selectedReviewIndex] : nil
    }

    var canShowPreviousReview: Bool { selectedReviewIndex > 0 }
    var canShowNextReview: Bool { selectedReviewIndex < reviews.count - 1 }

    func loadDetails() async {
        do {
            try await load {
                let result = try await service.fetchDetails(for: itemId)
                details = result
                isFavorited = result.isFavorited
                isAddedToCart = result.isAddedToCart
                selectedImageIndex = 0
                selectedReviewIndex = 0
            }
        } catch {
            errorMessage = "Failed to load item details"
        }
    }

    func toggleFavorite() { isFavorited.toggle() }
    func toggleCart() { isAddedToCart.toggle() }
    func buy() { isAddedToCart = true }

    func showNextReview() {
        if canShowNextReview { selectedReviewIndex += 1 }
    }

    func showPreviousReview() {
        if canShowPreviousReview { selectedReviewIndex -= 1 }
    }
}
