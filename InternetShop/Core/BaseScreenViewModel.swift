//
//  BaseScreenViewModel.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import Foundation
import Combine

@MainActor
class BaseScreenViewModel: ObservableObject {
    let title: String

    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""

    init(title: String) {
        self.title = title
    }

    func load(_ operation: () async -> Void) async {
        isLoading = true
        errorMessage = nil
        await operation()
        isLoading = false
    }
}
