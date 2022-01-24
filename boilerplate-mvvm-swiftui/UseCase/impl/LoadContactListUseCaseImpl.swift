//
//  ContactListService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Combine
import Repository

public class LoadContactListUseCaseImpl: LoadListUseCase<Contact> {
    private var contactRepository: ContactRepository
    public init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    override func forceToRefresh() {
        contactRepository.clearCachedDataIfNeeded()
    }
    
    public override func loadItems() throws -> Future<[Contact], Error> {
        return contactRepository.fetchContacts()
    }
    
    public override func loadItems(params: [String: Any]?) throws -> Future<[Contact], Error> {
        // TODO: Add params
        return contactRepository
            .fetchContacts(size: 20)
    }
}
