//
//  View+Extension.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI

public typealias ViewModelProviderCreate<V: ObservableObject> = () -> V

// Provide ViewModel
public protocol ProvideViewModelModifierProtocol: ViewModifier {
    associatedtype V where V: ObservableObject
}

public struct ProvideViewModelModifier<V: ObservableObject>: ProvideViewModelModifierProtocol {
    let viewModel: V
    
    public init(viewModel: V) {
        self.viewModel = viewModel
    }
    
    public func body(content: Content) -> some View {
        content.environmentObject(viewModel)
    }
}

public extension View {
    @ViewBuilder
    func provideViewModel<V: ObservableObject>(create: ViewModelProviderCreate<V>) -> some View {
        let viewModel = create()
        self.modifier(
            ProvideViewModelModifier(viewModel: viewModel)
        )
    }
}
