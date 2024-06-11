//
//  The_Composable_Architecture_iOS__ExampleApp.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import SwiftUI
import ComposableArchitecture


@main
struct The_Composable_Architecture_iOS__ExampleApp: App {
    let store: StoreOf<ContactFeature> = Store(initialState: ContactFeature.State()) {
        ContactFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            ContactsView(store: store)
        }
    }
}
