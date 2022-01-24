//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

public class ContactApiImpl: BaseApi, ContactApi {
    public init(baseUrl: BaseUrl, urlSession: URLSession = URLSession.shared) {
        super.init(baseUrl, urlSession: urlSession)
    }
    
    public func fetchContacts(withSize size: Int = 5) -> AnyPublisher<[Contact], Error> {
        return get(path: .fetchContacts(size: 5))
            .map { json -> [Contact] in
                let list = json["results"] as! [Dictionary<String, Any>]
                let contacts = list.map { Contact(dictionary: $0) }
                return contacts
            }
            .eraseToAnyPublisher()
    }
}

