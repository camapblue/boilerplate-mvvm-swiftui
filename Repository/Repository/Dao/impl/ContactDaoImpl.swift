//
//  ContactRepository.swift
//  iOSLiveCodingExam1
//
//  Created by @camapblue on 12/28/21.
//

import Foundation

public class ContactDaoImpl: BaseDao<Contact>, ContactDao {
    public init(userDefaults: UserDefaults = UserDefaults.standard, expiredTimeInMinute: Int? = nil) {
        super.init(userDefaults, expiredTimeInMinute: expiredTimeInMinute)
    }
    
    public func getCachedContacts() -> [Contact]? {
        return self.getItems(key: "key.contacts")
    }
    
    public func cacheContacts(contacts: [Contact]) {
        cacheItems(items: contacts, key: "key.contacts")
    }
    
    public func clearCachedContacts() {
        clearCache(key: "key.contacts")
    }
}
