//
//  InternetShopApp.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI
import UIKit

@main
struct InternetShopApp: App {
    init() {
        UISearchTextField.appearance().backgroundColor = .appDisabled
        UISearchTextField.appearance().clearButtonMode = .never
        Self.registerServices()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.appPrimary)
        }
    }

    private static func registerServices() {
        let networkClient = NetworkClient()
        let categoryService = CategoryService(networkClient: networkClient)
        ServiceLocator.shared.register(categoryService as any CatalogService, for: (any CatalogService).self)
    }
}
