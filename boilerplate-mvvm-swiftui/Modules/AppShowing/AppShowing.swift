//
//  AppShowing.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI
import POC_Common_UI_iOS

struct AppShowing: View {
    @EnvironmentObject private var viewModel: AppShowingViewModel
    
    let router = NavigationRouter(routes: .all)
    
    var content: some View {
        NavigationView {
            RouterView(
                router: router,
                root: .splash
            )
        }
        .environment(\.router, router)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var body: some View {
        if viewModel.isLoading {
            content.overlay(LoadingOverlay())
        } else {
            content
        }
    }
}

struct AppShowing_Previews: PreviewProvider {
    static var previews: some View {
        AppShowing()
    }
}
