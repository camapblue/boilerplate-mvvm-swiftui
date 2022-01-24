//
//  ContactExtension.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Repository

extension Contact {
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func age() -> Int {
        return birthday?.age() ?? 0
    }
    
    func fullAddress() -> String {
        return "\(street), \(city), \(state), \(country)"
    }
}
