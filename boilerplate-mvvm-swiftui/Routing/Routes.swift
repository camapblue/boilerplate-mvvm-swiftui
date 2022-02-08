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
    
    static func contactDetails(with contact: Contact) -> NavigationRouteLink {
        NavigationRouteLink(path: "/contact/\(contact.id)", meta: [
            "contact": contact,
        ])
    }
}

extension Array where Element == NavigationRoute {
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashScreen())
        
        let contactList = NavigationRoute(path: "/contactList") {
            ContactListScreen()
                .provideViewModel(create: {
                    ContactListViewModel(
                        loadListUseCase: UseCases.loadContactListUseCase(),
                        editContactUsecase: UseCases.editContactUseCase(),
                        contactManager: AppState.shared.contactManager()
                    )
                })
        }
        
        let contactDetails = NavigationRoute(path: "/contact/{id}") { route in
            ContactDetailScreen()
                .provideViewModel {
                    ContactDetailViewModel(
                        contact: route.link.meta["contact"] as! Contact,
                        editContactUsecase: UseCases.editContactUseCase(),
                        appShowingManager: AppState.shared.appShowingManager(),
                        contactManager: AppState.shared.contactManager()
                    )
                }
        }
        
        return [splash, contactList, contactDetails]
    }
}
