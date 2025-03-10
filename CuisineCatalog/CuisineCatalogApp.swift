//
//  CuisineCatalogApp.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/6/25.
//

import SwiftUI

@main
struct CuisineCatalogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: RecipeListViewModel(networkManager: NetworkManager()))
        }
    }
}
