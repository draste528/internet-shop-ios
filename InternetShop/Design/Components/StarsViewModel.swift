//
//  StarsViewModel.swift
//  InternetShop
//
//  Created by kair on 21.09.26.
//


import Foundation
import Combine

final class StarsViewModel: ObservableObject {
    let rating: Double
    let maxRating: Int
    let emptyIcon: String
    let halfIcon: String
    let fullIcon: String

    init(
        rating: Double,
        maxRating: Int = 5,
        emptyIcon: String = "star",
        halfIcon: String = "star.leadinghalf.filled",
        fullIcon: String = "star.fill"
    ) {
        self.rating = rating
        self.maxRating = maxRating
        self.emptyIcon = emptyIcon
        self.halfIcon = halfIcon
        self.fullIcon = fullIcon
    }

    func iconName(for index: Int) -> String {
        let starValue = rating - Double(index)
        if starValue >= 1 {
            return fullIcon
        } else if starValue >= 0.5 {
            return halfIcon
        } else {
            return emptyIcon
        }
    }
}
