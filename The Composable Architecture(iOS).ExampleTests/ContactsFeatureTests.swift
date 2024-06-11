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
    
    func testAddFlow_NonExhaustive() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        store.exhaustivity = .off
        
        await store.send(.addButtonTapped)
        await store.send(\.destination.addContact.setName, "Test")
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Test")
            ]
            $0.destination = nil
        }
    }
    
    func testDeleteContact() async {
        let store = TestStore(initialState: ContactFeature.State(contacts: [
            Contact(id: UUID(0), name: "Cindy"),
            Contact(id: UUID(1), name: "Ogneshka"),
        ])) {
            ContactFeature()
        }
        
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
        }
        
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
            $0.contacts.remove(id: UUID(1))
            $0.destination = nil
        }
    }
    
}
