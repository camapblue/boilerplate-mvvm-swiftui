//
//  ContactDaoTests.swift
//  RepositoryTests
//
//  Created by @camapblue on 1/3/22.
//

import XCTest
import Repository

class ContactDaoTests: XCTestCase {
    
    private var userDefaults: UserDefaults!
    private var contactDao: ContactDao!
    
    private var testingContacts = [
        Contact.fakeContact(id: "test_1"),
        Contact.fakeContact(id: "test_2")
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        userDefaults = UserDefaults(suiteName: "test_userdefaults")
        
        contactDao = ContactDaoImpl(userDefaults: userDefaults)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userDefaults.removePersistentDomain(forName: "test_userdefaults")
    }

    func testCacheContactsSuccess() throws {
        // when
        
        // given
        contactDao.cacheContacts(contacts: testingContacts)
        
        // then
        if let contacts = contactDao.getCachedContacts() {
            XCTAssert(contacts.count == testingContacts.count)
        } else {
            XCTFail("Can not found contacts")
        }
    }

    func testClearContactSuccess() throws {
        // when
        contactDao.cacheContacts(contacts: testingContacts)
        
        // given
        contactDao.clearCachedContacts()
        
        // then
        if let _ = contactDao.getCachedContacts() {
            XCTFail("Contacts do not clear")
        } else {
            XCTAssert(true)
        }
    }

}
