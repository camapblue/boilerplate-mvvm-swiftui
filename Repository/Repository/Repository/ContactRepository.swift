import Foundation
import Combine

public protocol ContactRepository {
    func clearCachedDataIfNeeded()
    
    func fetchContacts() -> Future<[Contact], Error>
    
    func fetchContacts(size: Int) -> Future<[Contact], Error>
    
    func edit(contact: Contact) -> Future<Contact, Error>
}
