//
//  AddContactView.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import Foundation
import ComposableArchitecture
import SwiftUI


struct AddContactView: View {
    /// @Perception.Bindable for previews versions
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(store: Store(
            initialState: AddContactFeature.State(
                contact:
                        .init(id: UUID(),
                              name: "Bob")
        )) {
            AddContactFeature()
        })
    }
    
}
