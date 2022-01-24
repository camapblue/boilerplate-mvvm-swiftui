//
//  Services.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Repository

// Dependency Injection for UseCase layer
class UseCases {
    static func editContactUseCase() -> EditContactUseCase {
        return EditContactUseCaseImpl(contactRepository: Repository.shared.contactRepository())
    }
    
    // list service
    static func loadContactListUseCase() -> LoadListUseCase<Contact> {
        return LoadContactListUseCaseImpl(contactRepository: Repository.shared.contactRepository())
    }
}

