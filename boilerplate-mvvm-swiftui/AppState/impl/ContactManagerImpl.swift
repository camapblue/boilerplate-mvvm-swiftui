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
    private let contactUpdatedSubject = PassthroughSubject<Contact, Never>()
    
    public var onContactUpdated: AnyPublisher<Contact, Never> {
        return contactUpdatedSubject.eraseToAnyPublisher()
    }
    
    public func updateContactSuccess(_ contact: Contact) {
        contactUpdatedSubject.send(contact)
    }
}
