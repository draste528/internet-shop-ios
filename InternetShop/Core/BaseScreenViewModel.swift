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

    // loading pattern
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    init(title: String) {
        self.title = title
    }

    func load(_ operation: () async throws -> Void) async {
        isLoading = true
        errorMessage = nil
        do {
            try await operation()
        } catch {
            errorMessage = "Something went wrong"
        }
        isLoading = false
    }
}
