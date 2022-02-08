//
//  ContactRepositoryTests.swift
//  RepositoryTests
//
//  Created by @camapblue on 1/3/22.
//

import XCTest
import Repository
import Mockingbird
import Combine

class ContactRepositoryTests: XCTestCase {
    
    private var contactDao: ContactDaoMock!
    private var contactApi: ContactApiMock!
    private var contactRepository: ContactRepository!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        contactDao = mock(ContactDao.self)
        contactApi = mock(ContactApi.self)
        contactRepository = ContactRepositoryImpl(contactDao: contactDao, contactApi: contactApi)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testFetchContactsWithoutCache() throws {
        // when
        given(contactApi.fetchContacts(withSize: 5)).willReturn(
            Future { promise in
                let items = [Contact.fakeContact()]
                promise(.success(items))
            }
            .eraseToAnyPublisher()
        )
        
        given(contactDao.getCachedContacts()).willReturn(nil)
        
        // given
        var contacts = [Contact]()
        var error: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        contactRepository
            .fetchContacts(size: 5)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            } receiveValue: { value in
                contacts = value
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNil(error)
        XCTAssertEqual(contacts.count, 1)
    }

}
