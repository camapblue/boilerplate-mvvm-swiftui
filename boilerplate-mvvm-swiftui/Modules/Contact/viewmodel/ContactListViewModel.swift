//
//  ContactListViewModel.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/24/22.
//

import Foundation
import Repository

class ContactListViewModel: LoadListViewModel<Contact> {
    init(loadListUseCase: LoadListUseCase<Contact>) {
        super.init(loadListUseCase: loadListUseCase)
    }
}
