//
//  Routes.swift
//  boilerplate-swiftui-bloc
//
//  Created by Hao Tran Thien on 05/01/2022.
//

import Repository
import SwiftUI

extension NavigationRouteLink {
    static var splash: NavigationRouteLink { "/splash" }
    static var storyBook: NavigationRouteLink { "/storyBook" }
    static var contactList: NavigationRouteLink { "/contactList" }
    
    static func contactDetails(with contactId: String) -> NavigationRouteLink {
        NavigationRouteLink(path: "/contact/\(contactId)", meta: [
            "contactId": contactId,
        ])
    }
}

extension Array where Element == NavigationRoute {
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashScreen())
        
        let contactList = NavigationRoute(path: "/contactList") {
            ContactListScreen()
                .provideViewModel(create: {
                    ContactListViewModel(loadListUseCase: UseCases.loadContactListUseCase())
                })
        }
        
        let contactDetails = NavigationRoute(path: "/contact/{id}") { route in
            ContactDetailScreen()
        }
        
        return [splash, contactList, contactDetails]
    }
}
