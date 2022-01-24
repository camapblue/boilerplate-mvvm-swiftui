//
//  File.swift
//  
//
//  Created by @camapblue on 12/28/21.
//

import Foundation
import Combine

public protocol ContactApi {
    func fetchContacts(withSize size: Int) -> AnyPublisher<[Contact], Error>
}

