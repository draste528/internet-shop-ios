//
//  ItemRowViewModel.swift
//  InternetShop
//
//  Created by kair on 21.09.26.
//


import Foundation
import Combine

final class ItemRowViewModel: ObservableObject {
    let item: Item

    init(item: Item) {
        self.item = item
    }

    var priceFormatted: String {
        String(format: "%.2f $", item.priceValue)
    }

    var imageURL: URL? {
            item.thumbnailURL.flatMap { URL(validatedString: $0) }
    }
}
