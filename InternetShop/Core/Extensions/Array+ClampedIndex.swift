//
//  Array+ClampedIndex.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

extension Array {
    /// Clamps `index` into `0..<count`.
    /// `max` is applied last, so an empty array gives 0 instead of -1.
    nonisolated func clampedIndex(_ index: Int) -> Int {
        Swift.max(Swift.min(index, count - 1), 0)
    }
}
