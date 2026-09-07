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
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.appPrimary)
        }
    }
}
