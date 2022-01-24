//
//  AppShowingManager.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/23/22.
//

import Foundation
import Combine

public protocol AppShowingManager {
    func globalLoadingUpdated() -> AnyPublisher<Bool, Never>
    
    func showGlobalLoading()
    
    func hideGlobalLoading()
}
