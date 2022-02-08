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
    private var contactManager: ContactManager
    private var disposables = Set<AnyCancellable>()
    
    public init(contactRepository: ContactRepository, contactManager: ContactManager) {
        self.contactRepository = contactRepository
        self.contactManager = contactManager
    }
    
    override func forceToRefresh() {
        contactRepository.clearCachedDataIfNeeded()
    }
    
    public override func loadItems() throws -> Future<[Contact], Error> {
        return Future { [unowned self] promise in
            self.contactRepository.fetchContacts()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    default: break
                    }
                }, receiveValue: { contacts in
                    self.contactManager.updateContactList(contacts)
                    promise(.success(contacts))
                })
                .store(in: &self.disposables)
        }
    }
    
    public override func loadItems(params: [String: Any]?) throws -> Future<[Contact], Error> {
        return Future { [unowned self] promise in
            self.contactRepository.fetchContacts(size: 20)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    default: break
                    }
                }, receiveValue: { contacts in
                    self.contactManager.updateContactList(contacts)
                    promise(.success(contacts))
                })
                .store(in: &self.disposables)
        }
    }
}
