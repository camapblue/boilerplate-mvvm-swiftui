//
//  BaseUrl.swift
//  Repository
//
//  Created by Hao Tran Thien on 07/01/2022.
//

import Foundation

public enum Endpoints {
    case fetchContacts(size: Int)
}

public class BaseUrl {
    let apiEndpointUrl: String
    
    init(apiEndpointUrl: String) {
        self.apiEndpointUrl = apiEndpointUrl
    }
    
    public convenience init() {
        self.init(apiEndpointUrl: "https://test.com")
    }
    
    public func path(for endpoint: Endpoints) -> String {
        switch endpoint {
        case .fetchContacts(let size):
            return "/?results=\(size)"
        }
    }
    
    public func getUrl(of endpoint: Endpoints) -> URL {
        return URL(string: "\(apiEndpointUrl)\(path(for: endpoint))")!
    }
}
