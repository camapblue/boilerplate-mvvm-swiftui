//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

public class ContactRepositoryImpl: ContactRepository {
    
    private var contactDao: ContactDao!
    private var contactApi: ContactApi!
    private var disposables = Set<AnyCancellable>()
    
    public init(contactDao: ContactDao, contactApi: ContactApi) {
        self.contactApi = contactApi
        self.contactDao = contactDao
    }
    
    public func clearCachedDataIfNeeded() {
        self.contactDao.clearCachedContacts()
    }
    
    public func fetchContacts() -> Future<[Contact], Error> {
        return fetchContacts(size: 5)
    }
    
    public func fetchContacts(size: Int) -> Future<[Contact], Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.success([Contact]()))
                return
            }
            if let cached = self.contactDao.getCachedContacts() {
                promise(.success(cached))
                return
            }
            
            self.contactApi.fetchContacts(withSize: size)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { items in
                    self.contactDao.cacheContacts(contacts: items)
                    promise(.success(items))
                })
                .store(in: &self.disposables)
        }
    }
    
    public func edit(contact: Contact) -> Future<Contact, Error> {
        return Future { promise in
            if (contact.id == "bug") {
                promise(.failure(ApiError.unknown))
                return
            }
            promise(.success(contact))
        }
    }
}
