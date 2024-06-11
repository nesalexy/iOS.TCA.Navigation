//
//  ContactDetailView.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    @Bindable var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
    
}

#Preview {
    ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: .init(id: UUID(),
                                                                                           name: "Bob")), reducer: {
        ContactDetailFeature()
    }))
}
