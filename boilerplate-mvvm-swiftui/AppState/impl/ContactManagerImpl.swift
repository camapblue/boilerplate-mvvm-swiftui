//
//  ContactManagerImpl.swift
//  boilerplate-mvvm-swiftui
//
//  Created by Hao Tran Thien on 24/01/2022.
//

import Foundation
import Combine
import Repository

public class ContactManagerImpl: ContactManager {
    private var contacts: [Contact]?
    private let contactListSubject = PassthroughSubject<[Contact], Never>()
    
    public var onContactListUpdated: AnyPublisher<[Contact], Never> {
        return contactListSubject.eraseToAnyPublisher()
    }
    
    public func updateContactList(_ contacts: [Contact]) {
        self.contacts = contacts
    }
    
    public func updateContact(_ contact: Contact) {
        guard var contacts = self.contacts else {
            return
        }
        
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index] = contact
        }
        contactListSubject.send(contacts)
    }
}
