//
//  LoadingView.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/29/21.
//

import SwiftUI

struct LoadingView: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            ZStack(alignment: .center) {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            }
        }
    }
}

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            ZStack(alignment: .center) {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            }
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
    }
}

extension View {
    @ViewBuilder
    func loadingOverlay(isLoading: Bool) -> some View {
        if isLoading {
            self.modifier(LoadingView())
        } else {
            self.modifier(EmptyModifier())
        }
    }
}
