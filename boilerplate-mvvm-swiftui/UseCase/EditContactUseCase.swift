//
//  ContactService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine
import Repository

public protocol EditContactUseCase {
    func edit(contact: Contact) -> Future<Contact, Error>
}
