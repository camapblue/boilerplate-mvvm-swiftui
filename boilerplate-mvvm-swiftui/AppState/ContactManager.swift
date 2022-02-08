//
//  ContactManager.swift
//  boilerplate-mvvm-swiftui
//
//  Created by Hao Tran Thien on 24/01/2022.
//

import Foundation
import Combine
import Repository

public protocol ContactManager {
    var onContactUpdated: AnyPublisher<Contact, Never> { get }
    
    func updateContactSuccess(_ contact: Contact)
}
