//
//  Destination.swift
//  The Composable Architecture(iOS).Example
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

import Foundation
import ComposableArchitecture


extension ContactFeature {
    
    @Reducer(state: .equatable)
    enum Destination {
        case addContact(AddContactFeature)
        case alert(AlertState<ContactFeature.Action.Alert>)
    }
    
}
