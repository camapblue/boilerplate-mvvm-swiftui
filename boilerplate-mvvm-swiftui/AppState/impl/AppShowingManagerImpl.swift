//
//  AppShowingManagerImpl.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/23/22.
//

import Foundation
import Combine

public class AppShowingManagerImpl: AppShowingManager {
    // state
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    
    public func globalLoadingUpdated() -> AnyPublisher<Bool, Never> {
        return isLoadingSubject.eraseToAnyPublisher()
    }
    
    public func showGlobalLoading() {
        isLoadingSubject.send(true)
    }
    
    public func hideGlobalLoading() {
        isLoadingSubject.send(false)
    }
}
