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
    
    @Published var contact: Contact
    @Published var editingFirstName: String = ""
    @Published var editingLastName: String = ""
    @Published var updateBtnEnable: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    init(
        contact: Contact,
        editContactUsecase: EditContactUseCase
    ) {
        self.contact = contact
        self.editContactUsecase = editContactUsecase
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
        editContactUsecase.edit(
                contact: contact.copyWith(
                    firstName: editingFirstName,
                    lastName: editingLastName
                )
            )
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    print("Error in edit contact")
                default: break
                }
            }, receiveValue: { [weak self] updatedContact in
                guard let self = self else { return }
                
                self.contact = updatedContact
                self.editingFirstName = ""
                self.editingLastName = ""
            })
            .store(in: &bag)
    }
}
