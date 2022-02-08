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
    private let contactManager: ContactManager
    
    private var bag = Set<AnyCancellable>()
    
    init(
        loadListUseCase: LoadListUseCase<Contact>,
        contactManager: ContactManager
    ) {
        self.contactManager = contactManager
        super.init(loadListUseCase: loadListUseCase)
        bindEvents()
    }
    
    private func bindEvents() {
        contactManager
            .onContactListUpdated
            .filter { [weak self] _ in
                return !(self?.isLoading ?? true)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] contacts in
                guard let self = self else { return }
                self.items = contacts
            })
            .store(in: &bag)
    }
}
