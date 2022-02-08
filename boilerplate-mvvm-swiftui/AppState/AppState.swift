//
//  AppState.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/23/22.
//

import Foundation

public class AppState {
    public static let shared = AppState()
    
    private let appShowingInstance = AppShowingManagerImpl()
    private let contactManagerInstance = ContactManagerImpl()
    
    // Manager
    func appShowingManager() -> AppShowingManager {
        return appShowingInstance
    }
    
    func contactManager() -> ContactManager {
        return contactManagerInstance
    }
}
