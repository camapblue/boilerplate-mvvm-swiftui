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
    var onContactListUpdated: AnyPublisher<[Contact], Never> { get }
    
    func updateContactList(_ contacts: [Contact])
    
    func updateContact(_ contact: Contact)
}
