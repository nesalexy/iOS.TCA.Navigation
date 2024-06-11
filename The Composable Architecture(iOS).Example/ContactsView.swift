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
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.contacts) { contact in
                    NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button {
                                store.send(.deleteButtonTapped(id: contact.id))
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .buttonStyle(.borderless)
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
        } destination: { store in
            ContactDetailView(store: store)
        }
        .sheet(
            item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
        ) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
        .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
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
