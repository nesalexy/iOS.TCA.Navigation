//
//  ContentView.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    /// @Perception.Bindable for previews versions
    @Bindable var store: StoreOf<ContactFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactFeature.State(
        contacts: [
            .init(id: UUID(), name: "Rosa"),
            .init(id: UUID(), name: "Bob")
        ]
    )) {
        ContactFeature()
    })
}
