//
//  InternetShopApp.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct InternetShopApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        UISearchTextField.appearance().backgroundColor = .appDisabled
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.appPrimary)
        }
        .modelContainer(sharedModelContainer)
    }
}
