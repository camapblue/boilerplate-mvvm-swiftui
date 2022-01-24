//
//  ContactDetailViewModel.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/24/22.
//

import Foundation
import Repository

class ContactDetailViewModel: ObservableObject {
    @Published var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
}
