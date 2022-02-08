//
//  ContactListViewModel.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/24/22.
//

import Foundation
import Repository
import Combine

class ContactListViewModel: LoadListViewModel<Contact> {
    private let editContactUsecase: EditContactUseCase
    private let contactManager: ContactManager
    
    private var bag = Set<AnyCancellable>()
    
    init(
        loadListUseCase: LoadListUseCase<Contact>,
        editContactUsecase: EditContactUseCase,
        contactManager: ContactManager
    ) {
        self.editContactUsecase = editContactUsecase
        self.contactManager = contactManager
        super.init(loadListUseCase: loadListUseCase)
        bindEvents()
    }
    
    private func bindEvents() {
        contactManager
            .onContactUpdated
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] updatedContact in
                guard let self = self else { return }
                var contacts = self.items
                if let contactIndex = contacts.firstIndex(where: { $0.id == updatedContact.id }) {
                    contacts[contactIndex] = updatedContact
                    self.items = contacts
                }
            })
            .store(in: &bag)
    }
}
