//
//  boilerplate_mvvm_swiftuiApp.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/23/22.
//

import SwiftUI

@main
struct boilerplate_swiftui_blocApp: App {
    var body: some Scene {
        WindowGroup {
            AppShowing()
                .provideViewModel(
                    create: { AppShowingViewModel(
                        appShowingManager: AppState.shared.appShowingManager()
                    )}
                )
        }
    }
}
