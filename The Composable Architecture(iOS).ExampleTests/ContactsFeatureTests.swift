//
//  ContactsFeatureTests.swift
//  The Composable Architecture(iOS).ExampleTests
//
//  Created by Alexy Nesterchuk on 11.06.2024.
//

@testable import The_Composable_Architecture_iOS__Example
import XCTest
import ComposableArchitecture

@MainActor
final class ContactsFeatureTests: XCTestCase {
    
    func testAddFlow() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(AddContactFeature.State(contact: .init(id: UUID(0), name: "")))
        }
        
        await store.send(\.destination.addContact.setName, "Test") {
            $0.destination?.addContact?.contact.name = "Test"
        }
        
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.receive(\.destination.addContact.delegate.saveContact, 
                             Contact(id: UUID(0), name: "Test")) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Test")
            ]
        }
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
}
