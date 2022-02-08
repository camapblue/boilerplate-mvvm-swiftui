//
//  ContactDetailViewModel.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/24/22.
//

import Foundation
import Repository
import Combine

class ContactDetailViewModel: ObservableObject {
    private let editContactUsecase: EditContactUseCase
    private let appShowingManager: AppShowingManager
    private let contactManager: ContactManager
    
    @Published var contact: Contact
    @Published var editingFirstName: String = ""
    @Published var editingLastName: String = ""
    @Published var updateBtnEnable: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    init(
        contact: Contact,
        editContactUsecase: EditContactUseCase,
        appShowingManager: AppShowingManager,
        contactManager: ContactManager
    ) {
        self.contact = contact
        self.editContactUsecase = editContactUsecase
        self.appShowingManager = appShowingManager
        self.contactManager = contactManager
        bindEvents()
    }
    
    func bindEvents() {
        $editingFirstName
            .sink { [weak self]_ in
                guard let self = self else { return }
                self.onNameChanged()
            }
            .store(in: &bag)
        
        $editingLastName
            .sink { [weak self]_ in
                guard let self = self else { return }
                self.onNameChanged()
            }
            .store(in: &bag)
    }
    
    func editBtnPressed() {
        editingFirstName = contact.firstName
        editingLastName = contact.lastName
    }
    
    private func onNameChanged() {
        updateBtnEnable =
        (editingFirstName != contact.firstName && !editingFirstName.isEmpty)
        || (editingLastName != contact.lastName && !editingLastName.isEmpty)
    }
    
    func updateBtnPressed() {
        appShowingManager.showGlobalLoading()
        editContactUsecase.edit(
            contact: contact.copyWith(
                firstName: editingFirstName,
                lastName: editingLastName
            )
        )
            .delay(for: 2, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    if let self = self {
                        // handleException()
                        
                        self.appShowingManager.hideGlobalLoading()
                    }
                }
            }, receiveValue: { [weak self] updatedContact in
                guard let self = self else { return }
                self.contactManager.updateContactSuccess(updatedContact)
                self.appShowingManager.hideGlobalLoading()
                self.contact = updatedContact
                self.editingFirstName = ""
                self.editingLastName = ""
                
            })
            .store(in: &bag)
    }
}
