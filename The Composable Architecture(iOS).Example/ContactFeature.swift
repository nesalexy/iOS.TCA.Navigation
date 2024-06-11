//
//  ContactFeature.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import Foundation
import ComposableArchitecture


struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: .init(id: UUID(), name: "")
                )
                return .none
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
                state.addContact = nil
                return .none
            case .addContact:
                return .none
            }
        }
        /*
         This creates a new reducer that runs the child reducer when a child
         action comes into the system, and runs the parent reducer on all actions.
         It also automatically handles effect cancellation when the child feature is dismissed
         */
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}
