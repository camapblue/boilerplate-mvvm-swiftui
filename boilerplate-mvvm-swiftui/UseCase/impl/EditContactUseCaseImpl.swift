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
    private var contactManager: ContactManager
    private var appShowingManager: AppShowingManager
    private var disposables = Set<AnyCancellable>()
    
    public init(contactRepository: ContactRepository, contactManager: ContactManager, appShowingManager: AppShowingManager) {
        self.contactRepository = contactRepository
        self.contactManager = contactManager
        self.appShowingManager = appShowingManager
    }
    
    public func edit(contact: Contact) -> Future<Contact, Error> {
        return Future { [unowned self] promise in
            self.appShowingManager.showGlobalLoading()
            self.contactRepository.edit(contact: contact)
                .delay(for: 2, scheduler: DispatchQueue.global())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.appShowingManager.hideGlobalLoading()
                        promise(.failure(error))
                    default: break
                    }
                }, receiveValue: { contact in
                    self.contactManager.updateContact(contact)
                    self.appShowingManager.hideGlobalLoading()
                    promise(.success(contact))
                })
                .store(in: &self.disposables)
        }
    }
}
