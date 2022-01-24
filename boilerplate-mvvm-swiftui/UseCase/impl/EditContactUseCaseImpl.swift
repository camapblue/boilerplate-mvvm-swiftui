//
//  ContactServiceImpl.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine
import Repository

public class EditContactUseCaseImpl: EditContactUseCase {
    private var contactRepository: ContactRepository!
    
    public init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    public func edit(contact: Contact) -> Future<Contact, Error> {
        return contactRepository.edit(contact: contact)
    }
}
