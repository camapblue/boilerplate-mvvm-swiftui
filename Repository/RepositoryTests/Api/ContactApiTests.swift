//
//  ContactApiTests.swift
//  RepositoryTests
//
//  Created by @camapblue on 1/8/22.
//

import XCTest
import Repository
import Mockingbird
import Combine

class ContactApiTests: XCTestCase {
    
    private var contactApi: ContactApi!
    private var cancellables: Set<AnyCancellable>!
    
    private let contactJson = """
     {
        "results":[
           {
              "gender":"male",
              "name":{
                 "title":"Mr",
                 "first":"Jared",
                 "last":"Crawford"
              },
              "location":{
                 "street":{
                    "number":4377,
                    "name":"Richmond Park"
                 },
                 "city":"Bandon",
                 "state":"Kilkenny",
                 "country":"Ireland",
                 "postcode":43102,
                 "coordinates":{
                    "latitude":"20.8368",
                    "longitude":"-164.9192"
                 },
                 "timezone":{
                    "offset":"+11:00",
                    "description":"Magadan, Solomon Islands, New Caledonia"
                 }
              },
              "email":"jared.crawford@example.com",
              "login":{
                 "uuid":"72f7a175-806d-42d6-8f32-c18bed1b0647",
                 "username":"bluedog815",
                 "password":"webster",
                 "salt":"Gcy1l1xH",
                 "md5":"fc7a3850d8583da1e504217bec26d8cf",
                 "sha1":"1e5d528da1f7879cfbfbfd8336a1f9eaa50f9d24",
                 "sha256":"9f0b86a89a2a2af6ea19653fe8ad8089659b3b26a89e035ba8c467f1d8aedd0c"
              },
              "dob":{
                 "date":"1949-09-14T15:45:50.584Z",
                 "age":73
              },
              "registered":{
                 "date":"2011-09-28T22:27:24.121Z",
                 "age":11
              },
              "phone":"071-817-0424",
              "cell":"081-015-6232",
              "id":{
                 "name":"PPS",
                 "value":"7058429T"
              },
              "picture":{
                 "large":"https://randomuser.me/api/portraits/men/71.jpg",
                 "medium":"https://randomuser.me/api/portraits/med/men/71.jpg",
                 "thumbnail":"https://randomuser.me/api/portraits/thumb/men/71.jpg"
              },
              "nat":"IE"
           }
        ],
        "info":{
           "seed":"7664dfe4d80b5d4c",
           "results":1,
           "page":1,
           "version":"1.3"
        }
     }
    """
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        cancellables = Set<AnyCancellable>()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        contactApi = ContactApiImpl(baseUrl: BaseUrl(), urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchContactsSuccess() throws {
        // when
        let data = contactJson.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            let url = BaseUrl().getUrl(of: .fetchContacts(size: 5))
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // given
        var contacts = [Contact]()
        var error: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        contactApi
            .fetchContacts(withSize: 5)
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

    func testFetchContactFailure() throws {
        // when
        let data = "".data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            let url = BaseUrl().getUrl(of: .fetchContacts(size: 5))
            let response = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // given
        var error: Error?
        let expectation = self.expectation(description: "Awaiting publisher")
        contactApi
            .fetchContacts(withSize: 5)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(error)
    }
}
