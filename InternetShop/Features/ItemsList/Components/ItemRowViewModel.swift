//
//  ItemRowViewModel.swift
//  InternetShop
//
//  Created by kair on 21.09.26.
//


import Foundation
import Combine

@MainActor
final class ItemRowViewModel: ObservableObject {
    @Published var item: Item

    init(item: Item) {
        self.item = item
    }

    var priceFormatted: String {
        let val = Double(item.price) ?? 0.0
        return String(format: "$%.2f", val)
    }

    var imageURL: URL? {
        guard let urlString = item.thumbnailURL,
              !urlString.isEmpty,
              urlString.hasPrefix("http") else {
            return nil
        }
        return URL(string: urlString)
    }
}
