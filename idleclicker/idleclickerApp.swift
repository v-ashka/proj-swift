//
//  idleclickerApp.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import SwiftUI

@main
struct idleclickerApp: App {
    @StateObject var viewModel = GameStateViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
