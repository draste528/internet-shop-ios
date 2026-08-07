//
//  HomeViewModel.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var showTabs = false

    func startShopping() {
        showTabs = true
    }
}
