//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation

public protocol ContactDao {
    func clearCachedContacts()
    
    func getCachedContacts() -> [Contact]?
    
    func cacheContacts(contacts: [Contact])
}
