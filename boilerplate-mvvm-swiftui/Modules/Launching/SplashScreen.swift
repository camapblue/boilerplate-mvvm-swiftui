//
//  ContentView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/27/21.
//

import SwiftUI
import Repository

struct SplashScreen: View {
    @Environment(\.router) var router
    
    var body: some View {
        ZStack {
            VStack {
                Text("Splash View")
                Button("Contact List") {
                    router.push(link: .contactList)
                }
                .navigationTitle("Splash")
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 0)
        }
        .onAppear() {
            print("Splash Screen Appear")
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
