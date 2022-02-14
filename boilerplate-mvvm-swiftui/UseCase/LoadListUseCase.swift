//
//  LoadListService.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import Foundation
import Combine

public class LoadListUseCase<Item: Equatable> {
    public func forceToRefresh() { }
    
    public func loadItems() throws -> Future<[Item], Error> { throw "not implemented yet" }
    
    public func loadItems(params: [String: Any]?) throws -> Future<[Item], Error> { throw "not implemented yet" }
}
