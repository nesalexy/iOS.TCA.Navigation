//
//  ContactDetailView.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            
        }
        .navigationTitle(Text(store.contact.name))
    }
    
}

#Preview {
    ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: .init(id: UUID(),
                                                                                  name: "Bob")), reducer: {
        ContactDetailFeature()
    }))
}
